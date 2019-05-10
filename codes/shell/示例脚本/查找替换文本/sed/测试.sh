#!/bin/bash

#测试，如果测试成功，如果没有标签，sed会跳转到结尾，如果有标签，就跳转到标签，如果测试失败，则不会跳转
sed -n '{s/first/matched/; t; s/This is the/No match on/}' test
