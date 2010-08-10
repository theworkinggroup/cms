# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{comfortable_mexican_sofa}
  s.version = "0.0.18.rails3"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Oleg Khabarov, The Working Group Inc"]
  s.date = %q{2010-08-10}
  s.description = %q{}
  s.email = %q{oleg@theworkinggroup.ca}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "CHANGELOG.rdoc",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "app/controllers/cms_admin/base_controller.rb",
     "app/controllers/cms_admin/categories_controller.rb",
     "app/controllers/cms_admin/layouts_controller.rb",
     "app/controllers/cms_admin/pages_controller.rb",
     "app/controllers/cms_admin/sites_controller.rb",
     "app/controllers/cms_admin/snippets_controller.rb",
     "app/controllers/cms_common/render_page.rb",
     "app/controllers/cms_content_controller.rb",
     "app/helpers/cms_helper.rb",
     "app/models/cms_block.rb",
     "app/models/cms_category.rb",
     "app/models/cms_layout.rb",
     "app/models/cms_page.rb",
     "app/models/cms_page_categorization.rb",
     "app/models/cms_site.rb",
     "app/models/cms_snippet.rb",
     "app/views/cms_admin/_flash_message.html.haml",
     "app/views/cms_admin/categories/_category.html.haml",
     "app/views/cms_admin/categories/_category_subform.html.haml",
     "app/views/cms_admin/categories/_form.html.haml",
     "app/views/cms_admin/categories/_new.html.haml",
     "app/views/cms_admin/categories/_toggle_link.html.haml",
     "app/views/cms_admin/categories/_tree_branch.html.haml",
     "app/views/cms_admin/categories/children.js.rjs",
     "app/views/cms_admin/categories/create.js.haml",
     "app/views/cms_admin/categories/edit.html.haml",
     "app/views/cms_admin/categories/index.html.haml",
     "app/views/cms_admin/categories/new.html.haml",
     "app/views/cms_admin/categories/show.html.haml",
     "app/views/cms_admin/layouts/_details.html.haml",
     "app/views/cms_admin/layouts/_form.html.haml",
     "app/views/cms_admin/layouts/_tree_branch.html.haml",
     "app/views/cms_admin/layouts/edit.html.haml",
     "app/views/cms_admin/layouts/index.html.haml",
     "app/views/cms_admin/layouts/new.html.haml",
     "app/views/cms_admin/pages/_details.html.haml",
     "app/views/cms_admin/pages/_form.html.haml",
     "app/views/cms_admin/pages/_form_blocks.html.haml",
     "app/views/cms_admin/pages/_tree_branch.html.haml",
     "app/views/cms_admin/pages/edit.html.haml",
     "app/views/cms_admin/pages/form_blocks.js.erb",
     "app/views/cms_admin/pages/index.html.haml",
     "app/views/cms_admin/pages/new.html.haml",
     "app/views/cms_admin/sites/_form.html.haml",
     "app/views/cms_admin/sites/_site.html.haml",
     "app/views/cms_admin/sites/edit.html.haml",
     "app/views/cms_admin/sites/index.html.haml",
     "app/views/cms_admin/sites/new.html.haml",
     "app/views/cms_admin/snippets/_form.html.haml",
     "app/views/cms_admin/snippets/edit.html.haml",
     "app/views/cms_admin/snippets/index.html.haml",
     "app/views/cms_admin/snippets/new.html.haml",
     "app/views/cms_content/show.xml.rxml",
     "app/views/cms_content/sitemap.xml.rxml",
     "app/views/layouts/cms_admin.html.haml",
     "comfortable_mexican_sofa.gemspec",
     "config/routes.rb",
     "init.rb",
     "lib/comfortable_mexican_sofa.rb",
     "lib/comfortable_mexican_sofa/acts_as_categorized.rb",
     "lib/comfortable_mexican_sofa/cms_acts_as_tree.rb",
     "lib/comfortable_mexican_sofa/cms_form_builder.rb",
     "lib/comfortable_mexican_sofa/cms_rails_extensions.rb",
     "lib/comfortable_mexican_sofa/cms_tag.rb",
     "lib/comfortable_mexican_sofa/cms_tags/.partial.rb.swp",
     "lib/comfortable_mexican_sofa/cms_tags/block.rb",
     "lib/comfortable_mexican_sofa/cms_tags/helper.rb",
     "lib/comfortable_mexican_sofa/cms_tags/page_block.rb",
     "lib/comfortable_mexican_sofa/cms_tags/partial.rb",
     "lib/comfortable_mexican_sofa/cms_tags/snippet.rb",
     "lib/comfortable_mexican_sofa/engine.rb",
     "lib/generators/cms_generator.rb",
     "lib/generators/templates/README",
     "lib/generators/templates/images/arrow_bottom.gif",
     "lib/generators/templates/images/arrow_right.gif",
     "lib/generators/templates/images/background.png",
     "lib/generators/templates/images/bg-button-green-34.gif",
     "lib/generators/templates/images/default-logo.png",
     "lib/generators/templates/images/icon_category.gif",
     "lib/generators/templates/images/icon_draft.gif",
     "lib/generators/templates/images/icon_layout.gif",
     "lib/generators/templates/images/icon_move.gif",
     "lib/generators/templates/images/icon_regular.gif",
     "lib/generators/templates/images/icon_snippet.gif",
     "lib/generators/templates/images/jquery_ui/ui-bg_diagonals-thick_18_b81900_40x40.png",
     "lib/generators/templates/images/jquery_ui/ui-bg_diagonals-thick_20_666666_40x40.png",
     "lib/generators/templates/images/jquery_ui/ui-bg_flat_10_000000_40x100.png",
     "lib/generators/templates/images/jquery_ui/ui-bg_glass_100_f6f6f6_1x400.png",
     "lib/generators/templates/images/jquery_ui/ui-bg_glass_100_fdf5ce_1x400.png",
     "lib/generators/templates/images/jquery_ui/ui-bg_glass_65_ffffff_1x400.png",
     "lib/generators/templates/images/jquery_ui/ui-bg_gloss-wave_35_f6a828_500x100.png",
     "lib/generators/templates/images/jquery_ui/ui-bg_highlight-soft_100_eeeeee_1x100.png",
     "lib/generators/templates/images/jquery_ui/ui-bg_highlight-soft_75_ffe45c_1x100.png",
     "lib/generators/templates/images/jquery_ui/ui-icons_222222_256x240.png",
     "lib/generators/templates/images/jquery_ui/ui-icons_228ef1_256x240.png",
     "lib/generators/templates/images/jquery_ui/ui-icons_ef8c08_256x240.png",
     "lib/generators/templates/images/jquery_ui/ui-icons_ffd27a_256x240.png",
     "lib/generators/templates/images/jquery_ui/ui-icons_ffffff_256x240.png",
     "lib/generators/templates/initializers/cms.rb",
     "lib/generators/templates/javascripts/cms.js",
     "lib/generators/templates/javascripts/codemirror.js",
     "lib/generators/templates/javascripts/jquery-ui.js",
     "lib/generators/templates/javascripts/jquery.js",
     "lib/generators/templates/javascripts/rails.js",
     "lib/generators/templates/javascripts/rteditor.js",
     "lib/generators/templates/migrations/create_cms.rb",
     "lib/generators/templates/migrations/fix_children_count.rb",
     "lib/generators/templates/stylesheets/cms_master.sass",
     "lib/generators/templates/stylesheets/jquery_ui.sass",
     "test/fixtures/cms_blocks.yml",
     "test/fixtures/cms_categories.yml",
     "test/fixtures/cms_layouts.yml",
     "test/fixtures/cms_page_categorizations.yml",
     "test/fixtures/cms_pages.yml",
     "test/fixtures/cms_snippets.yml",
     "test/functional/cms_admin/base_controller_test.rb",
     "test/functional/cms_admin/categories_controller_test.rb",
     "test/functional/cms_admin/layouts_controller_test.rb",
     "test/functional/cms_admin/pages_controller_test.rb",
     "test/functional/cms_admin/snippets_controller_test.rb",
     "test/functional/cms_content_controller_test.rb",
     "test/integration/route_order_test.rb",
     "test/rails_root/.gitignore",
     "test/rails_root/Gemfile",
     "test/rails_root/Gemfile.lock",
     "test/rails_root/README",
     "test/rails_root/Rakefile",
     "test/rails_root/app/controllers/application_controller.rb",
     "test/rails_root/app/helpers/application_helper.rb",
     "test/rails_root/app/views/complex_page/_example.html.erb",
     "test/rails_root/app/views/layouts/application.html.erb",
     "test/rails_root/config.ru",
     "test/rails_root/config/application.rb",
     "test/rails_root/config/boot.rb",
     "test/rails_root/config/database.yml",
     "test/rails_root/config/environment.rb",
     "test/rails_root/config/environments/development.rb",
     "test/rails_root/config/environments/production.rb",
     "test/rails_root/config/environments/test.rb",
     "test/rails_root/config/initializers/backtrace_silencers.rb",
     "test/rails_root/config/initializers/inflections.rb",
     "test/rails_root/config/initializers/mime_types.rb",
     "test/rails_root/config/initializers/secret_token.rb",
     "test/rails_root/config/initializers/session_store.rb",
     "test/rails_root/config/locales/en.yml",
     "test/rails_root/config/routes.rb",
     "test/rails_root/db/schema.rb",
     "test/rails_root/db/seeds.rb",
     "test/rails_root/doc/README_FOR_APP",
     "test/rails_root/lib/tasks/.gitkeep",
     "test/rails_root/public/404.html",
     "test/rails_root/public/422.html",
     "test/rails_root/public/500.html",
     "test/rails_root/public/favicon.ico",
     "test/rails_root/public/images/rails.png",
     "test/rails_root/public/index.html",
     "test/rails_root/public/javascripts/application.js",
     "test/rails_root/public/javascripts/controls.js",
     "test/rails_root/public/javascripts/dragdrop.js",
     "test/rails_root/public/javascripts/effects.js",
     "test/rails_root/public/javascripts/prototype.js",
     "test/rails_root/public/javascripts/rails.js",
     "test/rails_root/public/robots.txt",
     "test/rails_root/public/stylesheets/.gitkeep",
     "test/rails_root/public/stylesheets/sass/cms_master.sass",
     "test/rails_root/script/rails",
     "test/rails_root/test/performance/browsing_test.rb",
     "test/rails_root/test/test_helper.rb",
     "test/rails_root/vendor/plugins/.gitkeep",
     "test/test_helper.rb",
     "test/unit/cms_block_test.rb",
     "test/unit/cms_category_test.rb",
     "test/unit/cms_layout_test.rb",
     "test/unit/cms_page_categorization_test.rb",
     "test/unit/cms_page_test.rb",
     "test/unit/cms_snippet_test.rb",
     "test/unit/cms_tag_test.rb"
  ]
  s.homepage = %q{http://theworkinggroup.ca}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{ComfortableMexicanSofa is a Rails Engine CMS gem}
  s.test_files = [
    "test/functional/cms_admin/base_controller_test.rb",
     "test/functional/cms_admin/categories_controller_test.rb",
     "test/functional/cms_admin/layouts_controller_test.rb",
     "test/functional/cms_admin/pages_controller_test.rb",
     "test/functional/cms_admin/snippets_controller_test.rb",
     "test/functional/cms_content_controller_test.rb",
     "test/integration/route_order_test.rb",
     "test/rails_root/app/controllers/application_controller.rb",
     "test/rails_root/app/helpers/application_helper.rb",
     "test/rails_root/config/application.rb",
     "test/rails_root/config/boot.rb",
     "test/rails_root/config/environment.rb",
     "test/rails_root/config/environments/development.rb",
     "test/rails_root/config/environments/production.rb",
     "test/rails_root/config/environments/test.rb",
     "test/rails_root/config/initializers/backtrace_silencers.rb",
     "test/rails_root/config/initializers/inflections.rb",
     "test/rails_root/config/initializers/mime_types.rb",
     "test/rails_root/config/initializers/secret_token.rb",
     "test/rails_root/config/initializers/session_store.rb",
     "test/rails_root/config/routes.rb",
     "test/rails_root/db/schema.rb",
     "test/rails_root/db/seeds.rb",
     "test/rails_root/test/performance/browsing_test.rb",
     "test/rails_root/test/test_helper.rb",
     "test/test_helper.rb",
     "test/unit/cms_block_test.rb",
     "test/unit/cms_category_test.rb",
     "test/unit/cms_layout_test.rb",
     "test/unit/cms_page_categorization_test.rb",
     "test/unit/cms_page_test.rb",
     "test/unit/cms_snippet_test.rb",
     "test/unit/cms_tag_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<haml>, [">= 0"])
      s.add_runtime_dependency(%q<active_link_to>, [">= 0"])
    else
      s.add_dependency(%q<haml>, [">= 0"])
      s.add_dependency(%q<active_link_to>, [">= 0"])
    end
  else
    s.add_dependency(%q<haml>, [">= 0"])
    s.add_dependency(%q<active_link_to>, [">= 0"])
  end
end

