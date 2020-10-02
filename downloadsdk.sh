if [ `uname` = "Darwin" ];  then 
    wget -nv https://github.com/phracker/MacOSX-SDKs/releases/download/10.15/MacOSX10.9.sdk.tar.xz
    tar xzf MacOSX10.9.sdk.tar.xz
    if [[ ! -d MacOSX10.9.sdk ]]; then
        echo "Problem with download of the SDK"
    fi
    ls MacOSX10.9.sdk
    echo "CONDA_BUILD_SYSROOT:
 - `pwd`/MacOSX10.9.sdk
 " > ../conda/conda_build_config.yaml
    more ../conda/conda_build_config.yaml
fi
