class Kirby < Middleman::Extension
  def initialize(app, options_hash={}, &block)
    super
    # binding.pry
    # app.set :building, app.bu
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
    def kirby_content_area
      "<?php echo kirbytext($page->text()) ?>" if build?
    end
    def make_a_link(url, text)
      "<a href='#{url}'>#{text}</a>"
    end
  end
end
