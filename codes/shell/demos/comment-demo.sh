#!/usr/bin/env bash

#--------------------------------------------
# shell 注释示例
# author：zp
#--------------------------------------------

# echo '这是单行注释'

########## 这是分割线 ##########

: << EOF
echo '这是多行注释'
echo '这是多行注释'
echo '这是多行注释'
EOF

# Execute: ./comment-demo.sh
# Output: null
