#!/usr/bin/env bash

# 声明数组
## 声明数组方式一
animals[0]=Cat
animals[1]=Dog
animals[2]=Fish
## 声明数组方式二
colors=(Red Green Blue)


# 根据下标获取数组中的元素
echo "=========== 根据下标获取数组中的元素 ==========="
echo "\${colors[1]} : " ${colors[1]}
# 输出：
# ${colors[1]} :  Green


# 数组切片
echo "=========== 数组切片 ==========="
colors[1]="Dark Green"

echo "\${colors[*]} : "
printf "+ %s\n" ${colors[*]}
# 输出：
# + Red
# + Dark
# + Green
# + Blue

echo "\"\${colors[*]}\" : "
printf "+ %s\n" "${colors[*]}"
# 输出：
# + Red Dark Green Blue

echo "\"\${colors[@]}\" : "
printf "+ %s\n" "${colors[@]}"
# 输出：
# + Red
# + Dark
# + Green
# + Blue

echo "\"\${colors[@]:0:2}\" : " ${colors[@]:0:2} ### Red Dark Green

# 向数组中添加元素
echo "=========== 向数组中添加元素 ==========="
colors=(Yellow "${colors[@]}" Pink Black)
echo "\"\${colors[@]}\" : " ${colors[@]}
# 输出：
# Yellow Red Dark Green Blue Pink Black

# 向数组中删除元素
echo "=========== 向数组中删除元素 ==========="
unset colors[0]
echo "\"\${colors[@]}\" : " ${colors[@]}
# 输出：
# Red Dark Green Blue Pink Black

# 获取数组的长度
echo "=========== 获取数组的长度 ==========="
## 获取数组的长度方式一
echo "\${#colors[*]} : ${#colors[*]}"
## 获取数组的长度方式二
echo "\${#colors[@]} : ${#colors[@]}"


for (( i = 0; i < animals; i ++ )); do
  echo $i
done

