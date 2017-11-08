conda config --set always_yes yes
conda config --add channels openalea
if [[ ! "$ANACONDA_UPLOAD" = "openalea" ]]; then
  conda config --add channels $ANACONDA_UPLOAD
  if [[ ! "$ANACONDA_LABEL" = "main" ]]; then
      conda config --add channels $ANACONDA_UPLOAD/label/$ANACONDA_LABEL
  fi
else
  if [[ ! "$ANACONDA_LABEL" = "main" ]]; then
      conda config --add channels openalea/label/$ANACONDA_LABEL
  fi
fi
