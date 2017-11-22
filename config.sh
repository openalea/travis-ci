## Copyright [2017-2018] UMR MISTEA INRA, UMR LEPSE INRA,                ##
##                       UMR AGAP CIRAD, EPI Virtual Plants Inria        ##
##                                                                       ##
## This file is part of the StatisKit project. More information can be   ##
## found at                                                              ##
##                                                                       ##
##     http://autowig.rtfd.io                                            ##
##                                                                       ##
## The Apache Software Foundation (ASF) licenses this file to you under  ##
## the Apache License, Version 2.0 (the "License"); you may not use this ##
## file except in compliance with the License. You should have received  ##
## a copy of the Apache License, Version 2.0 along with this file; see   ##
## the file LICENSE. If not, you may obtain a copy of the License at     ##
##                                                                       ##
##     http://www.apache.org/licenses/LICENSE-2.0                        ##
##                                                                       ##
## Unless required by applicable law or agreed to in writing, software   ##
## distributed under the License is distributed on an "AS IS" BASIS,     ##
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or       ##
## mplied. See the License for the specific language governing           ##
## permissions and limitations under the License.                        ##

export TEST_LEVEL=1
conda config --set always_yes yes
conda config --add channels r
conda config --add channels statiskit
if [[ "$ANACONDA_LABEL" = "main" && ! "$TRAVIS_BRANCH" = "master" ]]; then
  export ANACONDA_LABEL="unstable"
fi
if [[ ! "$ANACONDA_LABEL" = "main" || ! "$ANACONDA_LABEL" = "unstable" ]]; then
  echo "Variable ANACONDA_LABEL set to '"$ANACONDA_LABEL"' instead of 'main' or 'unstable'"
  exit 1
fi
if [[ ! "$ANACONDA_UPLOAD" = "statiskit" ]]; then
  conda config --add channels statiskit/label/unstable
  conda config --add channels $ANACONDA_UPLOAD
  if [[ ! "$ANACONDA_LABEL" = "main" ]]; then
      conda config --add channels $ANACONDA_UPLOAD/label/$ANACONDA_LABEL
  fi
else
  if [[ ! "$ANACONDA_LABEL" = "main" ]]; then
      conda config --add channels statiskit/label/$ANACONDA_LABEL
  fi
fi
