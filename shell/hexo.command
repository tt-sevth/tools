#!/usr/bin/env sh
# autor: sevth
# site: sevth.com
# date: 2020-04-15 22:00:00
# mail: <sevthdev@gmail.com>

# shellcheck disable=SC2034
# shellcheck disable=SC2046
# shellcheck disable=SC2164
# shellcheck disable=SC2005
# shellcheck disable=SC1035
# shellcheck disable=SC2039
# shellcheck disable=SC2162
# shellcheck disable=SC2039
base_path="/Users/sevth/workspace/sevth"

# 以下文件保持默认不动
templete_path="/scaffolds"
post_path="/source/_posts"
page_path="/source"
draft_path="/source/_drafts"
Show_Help() {
  echo
  echo "Usage: ${0} <command>

  Commands:
  c  clean     Remove generated files and cache.
  d  deploy    Deploy your website.
  g  generate  Generate static files.
  h  help      Get help on a command.
  n  new       Create a new post.
  s  server    Start the server.
  v  version   Display version information.
  f  folder    open the folder
  gd generate-deploy  generate and deploy like: hexo g -d
  "
}

while :; do
    [ -z "$1" ] && break;
    case "$1" in
    h | help)
    Show_Help; exit 0
    ;;
    c | clean)
      clean_flag=y; break
      ;;
    d | deploy)
      deploy_flag=y; break
      ;;
    g | generate)
      generate_flag=y; break
      ;;
    n | new)
      new_flag=y; break
      ;;
    s | server)
      server_flag=y; break
      ;;
    v | version)
      version_flag=y; break
      ;;
    f | folder)
      folder_flag=y; break
      ;;
    gd | genreate-deploy)
      gd_flag=y; break
      ;;
      *)
      echo "error argument"; break
      ;;
    esac
done

Main() {
  while :; do
  clear
  printf "
  ------------------------------------------------------------
  \t autor: sevth
  \t website: sevth.com
  \t mail: <sevthdev@gmail.com>
  \t exit: please type ctrl + c
  ------------------------------------------------------------
  "

#输入文章类型
  read -p "> 1.输入要创建的文章类型(post/page/draft/other default:post): " post_type
  if [ ! -n "${post_type}" ]; then
      post_type="post"
  fi
  printf "  \033[0;33m[√] 文章类型为\033[0m: \033[0;32m${post_type}\033[0m
  \t
  "
#  输入标题
  while :; do
      read -p "> 2.请输入文章题目: " FileName
      if [ -n "$FileName" ]; then
        printf "  \033[0;33m[√] 文章题目是\033[0m: \033[0;32m${FileName}\033[0m
  \t
  "
        break
      else
        printf "  \033[0;31m[×] 文件名不能为空！\033[0m
  \t
  "
      fi
  done
#  如果创建页面，则不需要输入路径
  if [ "${post_type}" != "page" ]; then
    read -p "> 3.请输入存储路径(默认为s对应文件类型根目录): " user_path
    if [ -n "${user_path}" ]; then
    if [ "${user_path:0:1}" != "/" ]; then
    user_path="/${user_path}"
    fi
    if [ "${user_path:-1}" != "/" ]; then
    user_path="${user_path}/"
    fi
    else
    user_path="/"
    fi
  echo
  printf "  \033[0;33m[√] 存储路径是\033[0m: \033[0;32m${base_path}${user_path}\033[0m
  \t
  "
  fi
  printf "------------------------------------------------------------

  "
#  检查模板文件是否存在
  if [ ! -f "${base_path}${templete_path}/${post_type}.md" ]; then
    printf "  \033[0;31m[×] ${base_path}${templete_path}/${post_type}.md 模板文件不存在，请检查hexo文件夹是否设置正确\033[0m
  \t
  "
    exit 1;
  else
#    常规创建方法
    if [ "${post_type}" != "page" ]; then
      cd "${base_path}" && hexo new "${post_type}" --path="${user_path}${FileName}" "${FileName}"
    else
      cd "${base_path}" && hexo new page "${FileName}"
    fi
    if [ "${post_type}" == "draft" ]; then
      open "${base_path}${draft_path}${user_path}${FileName}.md"
    elif [ "${post_type}" == "page" ]; then
      open "${base_path}${page_path}/${FileName}/index.md"
    else
      open "${base_path}${post_path}${user_path}${FileName}.md"
    fi
  fi
  while :; do
      read -p "要发布文章吗？(yes/no)" post_check
      if [ "${post_check}" == "yes" ]; then
          cd "${base_path}" && hexo g -d
          exit 1;
      elif [ "${post_check}" == "no" ]; then
          exit 1;
      else
          printf "  \033[0;31m[×] 您必须输入 yes or no!\033[0m
  \t
  "
      fi
  done
  done
}

if [ $# == 0 ]; then
    Main
else
  if [ "${clean_flag}" == "y" ]; then
    cd "${base_path}" && hexo clean
  fi
  if [ "${deploy_flag}" == "y" ]; then
      cd "${base_path}" && hexo deploy
  fi
  if [ "${generate_flag}" == "y" ]; then
      cd "${base_path}" && hexo generate
  fi
  if [ "${new_flag}" == "y" ]; then
      Main
  fi
  if [ "${server_flag}" == "y" ]; then
      cd "${base_path}" && hexo server
  fi
  if [ "${version_flag}" == "y" ]; then
      cd "${base_path}" && hexo version
  fi
  if [ "${folder_flag}" == "y" ]; then
      open "${base_path}"
  fi
  if [ "${gd_flag}" == "y" ]; then
      cd "${base_path}" && hexo g -d
  fi
fi
