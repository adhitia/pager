# Pager

Forward-only filtered pager

## Installation

Add this line to your application's Gemfile:

    gem 'pager'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pager

## Usage

~~~
class Array
  include Pager
end
~~~

To start filtering and returns first 25 filtered posts:
~~~
posts = Post.all.to_a

@posts = posts.filtered_page(25) do |post|
  post.published?
end # => get the first 25 filtered posts

@posts2 = posts.filtered_page(25) do |post|
  post.published?
end # => get the next 25 filtered posts
~~~

To start filtering starts from explicit element:
~~~
@posts = posts.filtered_page(25, offset: Post.all[2]) do |post|
  post.published?
end
~~~

To get current offset
~~~
@posts = posts.filtered_page(25, offset: Post.all[2]) do |post|
  post.published?
end

next_offset = posts.current_offset
~~~

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
