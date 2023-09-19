[source](https://jdhao.github.io/2021/08/12/nvim_sumneko_lua_conf/)

```
mkdir -p $HOME/tools/ && cd $HOME/tools
git clone --depth=1 https://github.com/sumneko/lua-language-server/

cd lua-language-server
# if the cloning speed is too slow, edit .gitmodules and replace github.com
# with hub.fastgit.org, which should be faster than github.
git submodule update --init --recursive

# build on Linux
cd 3rd/luamake
compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild
```
