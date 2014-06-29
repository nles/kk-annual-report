class Kirby < Middleman::Extension
  def initialize(app, options_hash={}, &block)
    super
    # binding.pry
    # app.set :building, app.bu
    app.after_build do |builder|
      FileUtils.cp_r app.root+"/kirby_base/kirby/", app.root+"/"+app.build_dir
      FileUtils.cp_r app.root+"/kirby_base/site/", app.root+"/"+app.build_dir
      FileUtils.cp_r app.root+"/kirby_base/content/", app.root+"/"+app.build_dir
      FileUtils.cp_r app.root+"/kirby_base/panel/", app.root+"/"+app.build_dir
      FileUtils.cp_r app.root+"/kirby_base/.htaccess", app.root+"/"+app.build_dir
      FileUtils.cp_r app.root+"/kirby_base/index.php", app.root+"/"+app.build_dir
      #Dir.chdir()
      templatedir = app.root+"/"+app.build_dir+"/site/templates/"
      FileUtils.mkdir templatedir
      #FileUtils.mv Dir.glob('*.html'), app.root+"/"+app.build_dir+"/site/templates/"
      Dir.glob(app.root+"/"+app.build_dir+"/*.html").each do |f|
        filename = (File.basename(f,'.*') == "index") ? "default" : File.basename(f,'.*')
        FileUtils.mv f, "#{templatedir}#{filename}.php"
      end
      if `id www-admin > /dev/null 2>&1 && echo $?` == 0 && `id www-data > /dev/null 2>&1 && echo $?` == 0
        FileUtils.chown_R "www-admin", "www-data", app.root+"/"+app.build_dir+"/content/"
      end
      FileUtils.chmod_R 0775, app.root+"/"+app.build_dir+"/content/"
    end
  end
  helpers do
    def kirby_start_menu
      "<?php foreach($pages->visible() AS $p): ?>" if build?
    end
    def kirby_end_menu
      "<?php endforeach ?>" if build?
    end
    def kirby_active_menu_item
      "<?php echo ($p->isOpen()) ? 'active' : '' ?>" if build?
    end
    def kirby_menu_item_url
      "<?php echo $p->url() ?>" if build?
    end
    def kirby_page_title
      "<?php echo html($p->title()) ?>" if build?
    end
    def kirby_content_area(area_name)
      "<?php echo kirbytext($page->#{area_name}()) ?>" if build?
    end
    def make_a_link(url, text)
      "<a href='#{url}'>#{text}</a>"
    end
  end
end
