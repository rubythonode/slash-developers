#!/bin/bash
# make -C apiary publish

mc.uploader -t $SLASH_DEVELOPER_SPACE_KEY -s $SLASH_DEVELOPER_SPACE -c devDoc -p docs/index.md
