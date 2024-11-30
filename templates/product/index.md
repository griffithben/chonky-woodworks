+++
date = '{{ .Date }}'
draft = false
title = '{{ .Title }}'
type = '{{ .Type }}'
summary = '{{ .Title }} Summary'
listImage = './{{ .Product_path }}/{{ .Lowercase_title }}-1.jpg'
price = 99
images = [
    './{{ .Lowercase_title }}-1.jpg',
    './{{ .Lowercase_title }}-2.jpg',
    './{{ .Lowercase_title }}-3.jpg'
]
description = '{{ .Title }} Description'
facebookUrl = 'FB Marketplace Url'
+++

{{< product >}}