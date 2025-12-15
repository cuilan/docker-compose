
# elasticsearch 常用命令

```shell
# 查看集群信息
curl -X GET 'http://localhost:9200/'

# 查看节点信息
curl -X GET 'http://localhost:9200/_cat/nodes'
# 192.168.0.2 41 92 3 1.00 0.94 0.72 cdfhilmrstw * es01

# 创建索引
curl -X PUT 'http://localhost:9200/books'
# {"acknowledged":true,"shards_acknowledged":true,"index":"books"}

# 查询索引
curl -X GET 'http://localhost:9200/books'

# 创建document
curl -X POST "http://localhost:9200/books/_doc?pretty" -H 'Content-Type: application/json' -d'
{"name": "Java编程思想", "author": "张三", "release_date": "2022-06-01", "page_count": 470}
'

# 插入数据
curl -X POST "http://localhost:9200/_bulk?pretty" -H 'Content-Type: application/json' -d'
{ "index" : { "_index" : "books" } }
{"name": "Go语言编程实战", "author": "李四", "release_date": "2023-03-15", "page_count": 585}
{ "index" : { "_index" : "books" } }
{"name": "C++入门指南", "author": "王五", "release_date": "2024-06-01", "page_count": 311}
{ "index" : { "_index" : "books" } }
{"name": "1984", "author": "乔治奥威尔", "release_date": "1985-06-01", "page_count": 328}
{ "index" : { "_index" : "books" } }
{"name": "华氏451度", "author": "雷·布拉德伯里", "release_date": "1953-10-15", "page_count": 227}
{ "index" : { "_index" : "books" } }
{"name": "美丽新世界", "author": "奥尔德斯·赫胥黎", "release_date": "1932-06-01", "page_count": 268}
'

# 查询所有
curl -X GET "localhost:9200/books/_search?pretty"

# 匹配查询
curl -X POST "localhost:9200/books/_search?pretty" -H 'Content-Type: application/json' -d'
{
  "query": {
    "match": {
      "name": "java"
    }
  }
}
'



```