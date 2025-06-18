## 目录结构

* 必须包含 `annotations/` 目录，存放标注 JSON 文件，文件名可自定义

* 图像目录支持自由组织，允许单层或多级嵌套，标注文件中的 `file_name` 字段与图片路径一致即可

```bash
coco
  ├── annotations
  │   ├── coco.json
  ├── 1.jpg
  ├── data1
  │   ├── 2.jpg
  │   ├── 3.jpg
  │   └── sub_data
  │       ├── 4.jpg
  │       ├── 5.jpg
  │       ├── ...
  ├── data2
  |   ...
```



## json格式

基于coco补充的自定义字段如下：

* caption：对图片的文字描述

* meta：元数据

  * annotator：标注员数据

  * result\_type：结果类型。ground\_truth为实际结果，consensus\_test为一致性测试结果

  * rotate\_angle：目标框的旋转角度，顺时针为正，单位为度

  * point：点数据

  * line：线数据

  * relation：关系数据

    * subject\_uid：关系中的主语

    * object\_uid：关系中的宾语

```json
{
        "info": {                                       // 基本信息
                "description": "COCO 2017 Dataset",     // 描述
                "url": "http://cocodataset.org",        // 图片地址
                "version": "1.0",                       // 版本
                "year": 2017,                           // 年份
                "contributor": "COCO Consortium",       // 贡献者
                "date_created": "2017/09/01"            // 创建时间
        },

        "categories": [                                 // 标签列表
            {
                "id":1,                                 // 标签类别ID
                "name":"person"                         // 标签类别名
            },
            {
                "id":2,                                
                "name":"car"                       
            },
        ],

        "images": [                                      // 图片列表 
            {
                "id": 20289,                             // 图片的身份ID  
                "file_name": "000000020289.jpg",         // 图片文件名 
                "width": 300,                            // 图像宽度
                "height": 300                            // 图像高度
            },
            {
                "id": 45176,
                "file_name": "000000045176.jpg",
                "width": 300,
                "height": 300
            }
        ],

        "annotations": [                                  // 标注信息列表 
            {                                              
                "id": 1,                                  // 标注信息ID 
                "uid": "1b9c84e3-8798-47d8-9309-47c159d1fcca",
                "image_id": 8783148,                      // 图片ID     
                "category_id": 1,                         // 标签类别ID
                "bbox": [                                 // 目标框位置 [x,y,width,height]
                    92,
                    83.5,
                    237,
                    146
                ],
                "area": 34602,                           // 标注区域的面积
                "iscrowd": 0,                            // 用于区分单个物体标注(0)和群体区域标注(1)
                "meta": {                                // 自定义元信息
                    "annotator": 3,                      // 标注员信息
                    "result_type": "ground_truth",       // 标注结果类型。ground_truth为实际结果，consensus_test为一致性测试结果
                }
            },
            {                                            // 下面是其他标注信息，这里略掉
                ......
            }
        ]
}
```





### annotation内容

#### 目标框

```json
"annotations": [                                  
    {                                              
        "id": 1,                                  // 标注信息ID 
        "uid": "1b9c84e3-8798-47d8-9309-47c159d1fcca",
        "image_id": 8783148,                      // 图片ID     
        "category_id": 1,                         // 标签类别ID
        "bbox": [                                 // 目标框位置 [x,y,width,height]
            92,
            83.5,
            237,
            146
        ],
        "area": 34602,                           
        "iscrowd": 0,                            
        "meta": {                                
            "annotator": 3,                      
            "result_type": "ground_truth",       
            "rotate_angle": 0.36520144           // 目标框的旋转角度，顺时针为正，单位为度
        }
    }
] 
```



#### 关系

关系用于标注两个目标的关系，因此下例中包含了两个目标框用于说明

```json
"annotations": [
    {
        "id": 1,
        "uid": "1c80eeee-f8e7-4ae8-912a-00f52619cd9c",
        "image_id": 8783149,
        "category_id": 3,                   // 标签名为人
        "bbox": [
            240,
            13.5,
            149,
            330.5
        ],
        "area": 49244.5,
        "iscrowd": 0,
        "meta": {
            "annotator": 3,
            "result_type": "ground_truth"
        }
    },
    {
        "id": 2,
        "uid": "b3e4b2c7-8d40-4763-a3a9-f2e60c83ab03",
        "image_id": 8783149,
        "category_id": 4,                    // 标签名为马
        "bbox": [
            34,
            129.5,
            465,
            214.5
        ],
        "area": 99742.5,
        "iscrowd": 0,
        "meta": {
            "annotator": 3,
            "result_type": "ground_truth"
        }
    },
    {
        "id": 3,
        "uid": "398c4f29-05cd-4190-9d23-ceb566b1949d",
        "image_id": 8783149,
        "category_id": 5,                     // 标签名为骑
        "iscrowd": 0,
        "meta": {
            "annotator": 3,
            "result_type": "ground_truth",
            "relation": {                                                    // 关系数据
                "subject_uid": "1c80eeee-f8e7-4ae8-912a-00f52619cd9c",       // 关系中的主语
                "object_uid": "b3e4b2c7-8d40-4763-a3a9-f2e60c83ab03"         // 关系中的宾语
            }
        }
    }
]
```



#### 点

```json
"annotations": [                                  
    {                                             
        "id": 2,
        "uid": "f0098bf9-1d07-4ce8-9143-bca2145af012",
        "image_id": 8783148,
        "category_id": 1,
        "iscrowd": 0,
        "meta": {
            "annotator": 3,
            "result_type": "ground_truth",
            "point": {                           // 点数据
                "x": 60,
                "y": 51.5
            }
        }
    }
] 
```



#### 线

```json
"annotations": [                                  
    {                                             
        "id": 3,
        "uid": "ec3c815e-cad0-4a07-8b01-4c48d78320e0",
        "image_id": 8783149,
        "category_id": 1,
        "iscrowd": 0,
        "meta": {
            "annotator": 3,
            "result_type": "ground_truth",
            "line": [                             // 线数据
                {
                    "x": 54,
                    "y": 21.5
                },
                {
                    "x": 104,
                    "y": 106.5
                },
                {
                    "x": 190,
                    "y": 58.5
                }
            ]
        }
    }
] 
```



#### 分类标签

对于多标签的项目，一个标签使用一个实例表示

```json
"annotations": [                                  
    {                                             
        "id": 4,
        "image_id": 52178, 
        "category_id": 1,
        "iscrowd": 0, 
        "caption": "CAPTION_TEST",                // 对图片的文字描述
        "meta": {
            "annotator": 3,
            "result_type": "ground_truth"
        }
    }
] 
```

