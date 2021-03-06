#!/usr/bin/env bash

rm -dfr docs

echo "Processing Markdown"
for filename in $(find raw_docs -type f -name '*.md'); do

  echo $filename
  original_string=$filename
  string_to_replace_with=docs
  result_string="${original_string/raw_docs/$string_to_replace_with}"
  echo $result_string

  mkdir -p "$(dirname "$result_string")" && touch "$result_string"
  hercule $filename -o $result_string
  # Space ID
  sed -i -e 's/<space_id>/71rop70dkqaj/g' $result_string
  # Access token
  sed -i -e 's/<access_token>/297e67b247c1a77c1a23bb33bf4c32b81500519edd767a8384a4b8f8803fb971/g' $result_string
  # Specific entry ID
  sed -i -e 's/<entry_id>/5KsDBWseXY6QegucYAoacS/g' $result_string
  # Specific brand content type
  sed -i -e 's/<brand_content_type_id>/sFzTZbSuM8coEwygeUYes/g' $result_string
  # Specific product content type
  sed -i -e 's/<product_content_type_id>/2PqfXUJwE8qSYKuM0U6w8M/g' $result_string
  # SKU value
  sed -i -e 's/<sku_value>/B00E82D7I8/g' $result_string
  # Specific asset
  sed -i -e 's/<asset_id>/wtrHxeu3zEoEce2MokCSi/g' $result_string
done

rm -dfr docs/_partials
