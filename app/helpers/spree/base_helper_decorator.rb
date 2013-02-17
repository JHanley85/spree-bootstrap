Spree::BaseHelper.module_eval do

  def taxons_tree_bs(root_taxon, current_taxon, max_level = 1)
    return '' if max_level < 1 || root_taxon.children.empty?
    content_tag :ul, :class => 'dropdown-menu' do
      root_taxon.children.map do |taxon|
        css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'current' : nil
        content_tag :li, :class => css_class do
          link_to(taxon.name, seo_url(taxon)) +
              taxons_tree(taxon, current_taxon, max_level - 1)
        end
      end.join("\n").html_safe
    end
  end
  def link_to_bs_cart(text = nil)
    return "" if current_spree_page?(spree.cart_path)

    text = text ? h(text) : t('cart')
    css_class = nil

    if current_order.nil? or current_order.line_items.empty?
      text = "#{text}: (#{t('empty')})"
      css_class = 'empty'
    else
      text = "#{text}: (#{current_order.item_count})  <span class='amount'>#{current_order.display_total}</span>".html_safe
      css_class = 'full'
    end

    link_to "<span class='icon-shopping-cart'></span>#{text}".html_safe, spree.cart_path, :class => css_class
  end




end