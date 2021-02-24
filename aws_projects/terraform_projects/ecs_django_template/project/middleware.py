### The health check request comes from the EC2 instance since we do not know
### the private IP beforehand, this will ensure the /ing/ route returns a
### successful response.
from django.http import HttpResponse
from django.utils.deprecation import MiddlewareMixin

class FilterIPMiddleware(MiddlewareMixin):
    def process_request(self, request):
        if request.META["PATH_INFO"] == "/ping/":
            return HttpResponse("pong")
