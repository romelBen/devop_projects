from django.http import Http404


def login_required(function):
    """
    Decorator for views that checks if the user is logged in, raising a
    404 if not.

    Args:
        function (function): The function to wrap.

    Raises:
        (Http404) if the user is not logged in.
    """
    def wrap(request, *args, **kwargs):
        if not request.user.is_authenticated:
            raise Http404

        return function(request, *args, **kwargs)

    return wrap
