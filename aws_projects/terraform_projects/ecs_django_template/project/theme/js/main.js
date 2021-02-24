function like(id){
  document.getElementById('like_' + id).submit();
};

function post_create(url, data) {
  const Http = new XMLHttpRequest();
  Http.open('POST', url);
  Http.setRequestHeader('X-CSRFToken', csrfToken);
  Http.send(data);
  Http.onreadystatechange=(e)=>{
    location.reload();
  }
};

function post_delete(url) {
  const Http = new XMLHttpRequest();
  Http.open('DELETE', url);
  console.log(csrfToken);
  Http.setRequestHeader('X-CSRFToken', csrfToken);
  Http.send();
  Http.onreadystatechange=(e)=>{
    location.reload();
  }
};

function post_like(url) {
  const Http = new XMLHttpRequest();
  Http.open('POST', url);
  Http.setRequestHeader('X-CSRFToken', csrfToken);
  Http.send();
  Http.onreadystatechange=(e)=>{
    location.reload();
  }
};

