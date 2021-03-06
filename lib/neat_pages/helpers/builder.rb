class NeatPages::Helpers::Builder
  def initialize(pagination, base_url, params)
    @pagination = pagination
    @base_url = base_url
    @params = params

    reset_builder
  end

  def b(str='')
    @builder << str

    return @builder.html_safe
  end

  def li(content, css_class='', hidden=false)
    attributes = 'class="' + css_class + '" '
    attributes << 'style="display:none"' if hidden

    return "<li #{attributes}>#{content}</li>"
  end

  def path_to(page)
    qs = ["page=#{page}"]

    @params.each { |k,v| qs << "#{k}=#{v}" if k != 'page' }

    return @base_url + '?' + qs.join("&")
  end

  def reset_builder
    @builder = ''
  end

  def t(text_path)
    (defined? I18n) ? I18n.t("neat_pages.#{text_path}") : text_path
  end

  def method_missing(*args, &block)
    if @pagination.respond_to? args.first
      return @pagination.send *args, &block
    else
      raise NoMethodError.new("undefined local variable or method '#{args.first}' for #{self.class}")
    end
  end

end
