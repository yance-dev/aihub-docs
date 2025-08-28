## 目录结构

```bash
voc
 ├── images                                         ## 图像文件夹
 │   ├── <image_name1>.jpg
 │   ├── <image_name2>.jpg
 │   └── <image_nameN>.jpg
 └── annotations                                    ## 标注文件夹
 │   ├── <image_name1>.xml
 │   ├── <image_name2>.xml
 │   └── <image_nameN>.xml
```



## xml格式

基于voc补充的自定义字段如下：

* meta：元数据，用于扩展数据

  * annotator：标注员信息

  * result\_type：结果类型。ground\_truth为实际结果，consensus\_test为一致性测试结果

  * rotate\_angle：目标框的旋转角度，顺时针为正，单位为度

  * point：点数据

  * line：线数据

  * relation：关系数据

    * subject\_uid：关系中的主语

    * object\_uid：关系中的宾语

```xml
<annotation>
  <folder>VOC2012</folder>                          ## 图像所在文件夹
  <filename>2007_000032.jpg</filename>              ## 图像文件名
  <size>                                            ## 图像尺寸信息
    <width>500</width>                              ## 图像宽度
    <height>281</height>                            ## 图像高度
    <depth>3</depth>                                ## 图像深度，也就是通道数
  </size>
 
  <object>                                          
    <name>aeroplane</name>                          ## 类别名
    <pose>Frontal</pose>                            ## 拍摄角度，Unspecified
    <truncated>0</truncated>                        ## 是否被截断，0表示完整未截断
    <difficult>0</difficult>                        ## 是否难以识别，0表示不难识别
    <bndbox>                                        ## 目标框信息
      <xmin>104</xmin>                              ## 左上角x
      <ymin>78</ymin>                               ## 左上角y
      <xmax>375</xmax>                              ## 右下角x
      <ymax>183</ymax>                              ## 右下角y
    </bndbox>
    <meta>                                          ## 自定义元信息
        <UID>1b9c84e3-8798-47d8-9309-47c159d1fcca</UID>             
        <annotator>3</annotator>                    ## 标注员信息
        <result_type>ground_truth</result_type>     ## 结果类型。ground_truth为实际结果，consensus_test为一致性测试结果
    </meta>
  </object>
  
  <object>                                          ## 下面是其他标注信息，这里略掉
    ...
  </object>
</annotation>
```



### object内容

#### 目标框

```xml
<object>                                          
    <name>aeroplane</name>                          ## 目标的类别名
    <pose>Frontal</pose>                            
    <truncated>0</truncated>                        
    <difficult>0</difficult>                        
    <bndbox>                                        
      <xmin>104</xmin>                              
      <ymin>78</ymin>                               
      <xmax>375</xmax>                              
      <ymax>183</ymax>                             
    </bndbox>
    <meta>                                          
        <UID>1b9c84e3-8798-47d8-9309-47c159d1fcca</UID>             
        <annotator>3</annotator>                    
        <result_type>ground_truth</result_type>    
        <rotate_angle>0.36520144</rotate_angle>     ## 目标框的旋转角度，顺时针为正，单位为度
    </meta>
  </object>
```



#### 关系

关系用于标注两个目标的关系，因此下例中包含了两个目标框用于说明

```xml
<object>
    <name>人</name>
    <pose></pose>
    <truncated>0</truncated>
    <difficult>0</difficult>
    <bndbox>
      <xmin>240</xmin>
      <ymin>13</ymin>
      <xmax>389</xmax>
      <ymax>344</ymax>
    </bndbox>
    <meta>
      <UID>1c80eeee-f8e7-4ae8-912a-00f52619cd9c</UID>
      <annotator>3</annotator>
      <result_type>ground_truth</result_type>
    </meta>
  </object>
  
  <object>
    <name>马</name>
    <pose></pose>
    <truncated>0</truncated>
    <difficult>0</difficult>
    <bndbox>
      <xmin>34</xmin>
      <ymin>129</ymin>
      <xmax>499</xmax>
      <ymax>344</ymax>
    </bndbox>
    <meta>
      <UID>b3e4b2c7-8d40-4763-a3a9-f2e60c83ab03</UID>
      <annotator>3</annotator>
      <result_type>ground_truth</result_type>
    </meta>
  </object>
  
  <object>
    <name>骑</name>
    <pose></pose>
    <truncated>0</truncated>
    <difficult>0</difficult>
    <bndbox>
      <xmin>0</xmin>
      <ymin>0</ymin>
      <xmax>0</xmax>
      <ymax>0</ymax>
    </bndbox>
    <meta>
      <UID>398c4f29-05cd-4190-9d23-ceb566b1949d</UID>
      <annotator>3</annotator>
      <result_type>ground_truth</result_type>
      <relation>                                                           //关系数据
        <subject_uid>1c80eeee-f8e7-4ae8-912a-00f52619cd9c</subject_uid>    //关系中的主语
        <object_uid>b3e4b2c7-8d40-4763-a3a9-f2e60c83ab03</object_uid>      //关系中的宾语
      </relation>
    </meta>
  </object>
```



#### 点

```xml
<object>                                          
    <name>人</name>
    <pose></pose>
    <truncated>0</truncated>
    <difficult>0</difficult>
    <bndbox>
      <xmin>0</xmin>
      <ymin>0</ymin>
      <xmax>0</xmax>
      <ymax>0</ymax>
    </bndbox>
    <meta>
      <UID>f0098bf9-1d07-4ce8-9143-bca2145af012</UID>
      <annotator>3</annotator>
      <result_type>ground_truth</result_type>
      <prompt>person</prompt>
      <point>                                       ## 点数据
        <X>60</X>
        <Y>51.5</Y>
      </point>
    </meta>
  </object>
```



#### 线

```xml
<object>                                           
    <name>车</name>
    <pose></pose>
    <truncated>0</truncated>
    <difficult>0</difficult>
    <bndbox>
      <xmin>0</xmin>
      <ymin>0</ymin>
      <xmax>0</xmax>
      <ymax>0</ymax>
    </bndbox>
    <meta>
      <UID>ec3c815e-cad0-4a07-8b01-4c48d78320e0</UID>
      <annotator>3</annotator>
      <result_type>ground_truth</result_type>
      <line>                                         ## 线数据
        <X>54</X>
        <Y>21.5</Y>
      </line>
      <line>
        <X>104</X>
        <Y>106.5</Y>
      </line>
      <line>
        <X>190</X>
        <Y>58.5</Y>
      </line>
    </meta>
  </object>
```



#### 分类标签

对于多标签的项目，一个标签使用一个object表示

```xml
 <object>                                          
    <name>person</name>                            
    <pose></pose>                            
    <truncated>0</truncated>                        
    <difficult>0</difficult>                       
    <bndbox>                                       
      <xmin>0</xmin>                              
      <ymin>0</ymin>                              
      <xmax>0</xmax>                              
      <ymax>0</ymax>                              
    </bndbox>
    <meta>                                          
        <UID>1b9c84e3-8798-47d8-9309-47c159d1fcca</UID>             
        <annotator>3</annotator>                    
        <result_type>ground_truth</result_type>     
    </meta>
  </object>
```

