# --- Build Stage ---
# 使用一个包含 Python 的基础镜像来编译 MkDocs 项目
FROM 192.168.14.129:80/library/python:3.9-slim as build-stage

# 设置工作目录
WORKDIR /app

# 复制你的 MkDocs 项目文件
# 确保你的 mkdocs.yml 和 docs/ 目录都在这里被复制
COPY . /app/

# 安装 MkDocs 和你使用的插件
# 建议在项目根目录创建一个 requirements.txt 文件来管理依赖
# 例如：
# mkdocs-material
# mkdocs-glightbox
COPY requirements.txt .
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip install --no-cache-dir -r requirements.txt

# 如果没有 requirements.txt，可以直接安装：
# RUN pip install --no-cache-dir mkdocs-material mkdocs-glightbox

# 创建临时目录用于统一存放所有文档
RUN mkdir -p /app/tmp

# 编译所有包含 mkdocs.yml 的一级目录并复制到临时目录
RUN find /app -maxdepth 1 -type d -exec sh -c 'for dir do [ -f "$dir/mkdocs.yml" ] && (cd "$dir" && mkdocs build && cp -r site /app/tmp/$(basename "$dir")); done' sh {} +

# --- Nginx Serve Stage ---
# 使用轻量级的 Nginx 镜像作为最终的运行时环境
FROM nginx:stable-alpine

# 移除 Nginx 默认的欢迎页，避免冲突
RUN rm -rf /usr/share/nginx/html/*

# 复制自定义 Nginx 配置以支持子目录访问
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# 将构建阶段生成的静态文件从 /app/site 复制到 Nginx 的默认 HTML 目录
# 复制所有编译好的文档到 Nginx 目录
COPY --from=build-stage /app/tmp /usr/share/nginx/html

# 暴露 80 端口，这是 Nginx 默认监听的端口
EXPOSE 80

# 启动 Nginx 服务
CMD ["nginx", "-g", "daemon off;"]