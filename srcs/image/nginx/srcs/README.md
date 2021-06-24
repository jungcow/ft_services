## nginx configuration
#### redirect part
```
location = /wordpress {
	return 307 http://$host:5050;
}
```
- `=` 은 정확히 맞는 URL이 와야 함을 뜻한다.
- 즉, `localhost/wordpress` 가 들어올 때만 위 location 블록에 들어가게 된다.
	- `localhost/wordpress/` -> X
	- `localhost/wordpress/index.php` -> X

```
location ~* "^/wordpress/(.*)$" {
	return 307  http://$host:5050/$1$is_args$args;
}
```
- `~*` 은 **case-insensitive** 정규 표현이다.
- 즉, 뒤에 적은 URL이 대문자든 소문자든 상관없이 다 location 블록 안으로 들어올 수 있다는 뜻
	- `localhost/Wordpress` -> O
	- `localhost/WORDPRESS/` -> O
	- `localhost/wordpress/INDEX.pHP` -> X
	- 위가 안되는 이유는 명시해놓은 url이 `wordpress` 이므로 다른 곳에 적용시키면 안된다.
- `^/`는 wordpress 로 시작한다는 뜻이다.
- `(.*)` 는 모든 확장자가 가능하다는 것이다.
	- `localhost/wordpress/index.js` -> O
	- `localhost/wordpress/index.php` -> O
- `$` 는 `(.*)` 이 마지막이라는 것을 의미한다.
	- `localhost/wordpress/index.js/admin` -> X
	- `localhost/wordpress/index.php` -> O
- `$host`: Host URL이 들어온다. host 주소는 다음과 같다.
	- `www.naver.com` -> `www`
	- `mail.naver.com` -> `mail`
	- `search.google.com` -> `search`
	- `naver.com`이나 `google.com` 은 도메인 주소라고 한다.
- `$1`: 위 location 블록의 url정의하는 부분에서 regex 표현에서 변하지 않는 부분중 `$n`이라면 n번째 부분을 가져오는 변수이다.
- `$is_args$args` : `is_args`에는 query string이 올 때만 `?`물음표가 들어가게 된다.
	`$args` 에는 querystring이 들어가게 된다.
	- `localhost/wordpress/wp-admin?page=1&search=hello` -> is_args에는 물음표가 할당되고, args에는 page=1&search=hello가 할당된다.
	- `localhost/wordpress/wp-admin/`일 경우엔 is_args엔 아무것도 안들어가고 args에도 아무것도 안들어간다.
	- `$args`와 동일한 결과를 가지는 변수는 `query_string` 이다.


__
## 참고자료
- [regex in location block](https://www.thegeekstuff.com/2017/05/nginx-location-examples/)
- [regex in location block $1, $2](https://www.thegeekstuff.com/2017/08/nginx-rewrite-examples/)
- [nginx variables](https://nginx.org/en/docs/varindex.html)
