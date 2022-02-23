# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Benchmark performance", type: :feature do
  let(:admin) { create :user, :as_admin }
  let(:user) { create :user }
  let(:blog) { Blog.first }

  before do
    load Rails.root.join("db/seeds.rb")
    Blog.first.update blog_name: "Awesome!", base_url: "http://www.example.com/"

    create(:article,
           body: <<~MARKDOWN,
             in markdown format

              * we
              * use
             [ok](http://blog.ok.com) to define a link
           MARKDOWN
           text_filter_name: "markdown")
    create(:article, body: "xyz")
  end

  scenario "admin changing themes" do
    Benchmark.ips do |x|
      x.report 'admin changing themes' do
        sign_in admin
        visit "/admin/themes"

        click_link_or_button "Use this theme"
      end
    end
  end

  scenario "user searching articles" do
    Benchmark.ips do |x|
      x.report 'user searching articles' do
        sign_in user
        visit "/search/a"
      end
    end
  end
end
