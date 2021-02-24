# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.http import Http404
from django.shortcuts import render

from project.posts.models import Post


def post(request, pk):
    post = Post.objects.get(pk=pk, date_deleted__isnull=True)
    if not post:
        raise Http404

    replies = Post.objects.filter(
        parent=post.pk,
        date_deleted__isnull=True,
    ).order_by('date_created')

    context = {'post': post, 'replies': replies}
    return render(request, 'post.html', context)
