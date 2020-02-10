#!/usr/bin/env sh

# ------------------------------------------------------------------------------
# gh-pages 部署脚本
# @author Zhang Peng
# @since 2020/2/10
# ------------------------------------------------------------------------------

# 装载其它库
ROOT_DIR=$(cd `dirname $0`/..; pwd)

# 确保脚本抛出遇到的错误
set -e

cd ${ROOT_DIR}/docs

# 生成静态文件
npm install
npm run build

# 进入生成的文件夹
cd dist

# 如果是发布到自定义域名
# echo 'www.example.com' > CNAME

git init
git checkout -b gh-pages && git add .
git commit -m 'deploy'

# 如果发布到 https://<USERNAME>.github.io/<REPO>
if [[ ${GITHUB_TOKEN} && ${GITEE_TOKEN} ]]; then
    echo "使用 token 公钥部署 gh-pages"
    # ${GITHUB_TOKEN} 是 Github 私人令牌；${GITEE_TOKEN} 是 Gitee 私人令牌
    # ${GITHUB_TOKEN} 和 ${GITEE_TOKEN} 都是环境变量；travis-ci 构建时会传入变量
    git push --force --quiet "https://dunwu:${GITHUB_TOKEN}@github.com/dunwu/linux-tutorial.git" gh-pages
    git push --force --quiet "https://turnon:${GITEE_TOKEN}@gitee.com/turnon/linux-tutorial.git" gh-pages
else
    echo "使用 ssh 公钥部署 gh-pages"
    git push -f git@github.com:dunwu/linux-tutorial.git gh-pages
    git push -f git@gitee.com:turnon/linux-tutorial.git gh-pages
fi

cd ${ROOT_DIR}
