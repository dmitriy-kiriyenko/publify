# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the
# db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Daley', city: cities.first)

blog = Blog.first || Blog.create!

unless blog.configured?
  blog.update!(blog_name: 'Lorem Ipsum', base_url: 'http://127.0.0.1:3000')
end

unless User.any?
  User.create!(email: 'john@doe.com', login: 'john', password: '12345678')
end

unless blog.sidebars.any?
  PageSidebar.create!(active_position: 0, staged_position: 0, blog_id: blog.id)
  TagSidebar.create!(active_position: 1, blog_id: blog.id)
  ArchivesSidebar.create!(active_position: 2, blog_id: blog.id)
  StaticSidebar.create!(active_position: 3, blog_id: blog.id)
  MetaSidebar.create!(active_position: 4, blog_id: blog.id)
end

unless blog.articles.any?
  2.times do |i|
    blog.arcticles.create!(
      body: <<~MARKDOWN,
        in markdown format

         * we
         * use
        [ok](http://blog.ok.com) to define a link
        #{i % 2 == 0 ? 'aaa' : 'bbb'}
      MARKDOWN
      title: "Lorem Ipsum #{i}",
      state: 'published',
      text_filter_name: 'markdown'
    )
  end
end

unless File.directory?("#{::Rails.root}/public/files")
  Dir.mkdir("#{::Rails.root}/public/files")
end
