{% macro render(is_post) %}
  

  <aside id="sidebar" class="sidebar">

    {% if theme.sidebar.onmobile %}
      {% if theme.sidebar.dimmer %}
        <div id="sidebar-dimmer"></div>
      {% endif %}
    {% endif %}

    <div class="sidebar-inner">
    
      <div class="sidebar-toggle-inside motion-element">
        <div class="sidebar-toggle-line-wrap">
          <span class="sidebar-toggle-line sidebar-toggle-line-first"></span>
          <span class="sidebar-toggle-line sidebar-toggle-line-middle"></span>
          <span class="sidebar-toggle-line sidebar-toggle-line-last"></span>
        </div>
      </div>

      {% set display_toc = is_post and theme.toc.enable or is_page and theme.toc.enable %}

      {% if display_toc and toc(page.content).length > 1 %}
        <ul class="sidebar-nav motion-element">
          <li class="sidebar-nav-toc sidebar-nav-active" data-target="post-toc-wrap" >
            {{ __('sidebar.toc') }}
          </li>
          <li class="sidebar-nav-overview" data-target="site-overview">
            {{ __('sidebar.overview') }}
          </li>
        </ul>
      {% endif %}

      <section class="site-overview sidebar-panel{% if not display_toc or toc(page.content).length <= 1 %} sidebar-panel-active{% endif %}">
        <div class="site-author motion-element" itemprop="author" itemscope itemtype="http://schema.org/Person">
          <a href="/" class="site-author-image" rel="start" style="border:none">
            <img class="site-author-image" itemprop="image"
                src="{{ url_for( theme.avatar | default(theme.images + '/avatar.gif') ) }}"
                alt="{{ theme.author }}" 
            />
          </a>
          <p class="site-author-name" itemprop="name">{{ theme.author }}</p>
           {% if theme.seo %}
              <p class="site-description motion-element" itemprop="description">{{ theme.signature }}</p>
           {% else %}
              <p class="site-description motion-element" itemprop="description">{{ theme.description }}</p>
          {% endif %}
        </div>

        <nav class="site-state motion-element">

          {% if site.categories.length > 0 %}
            {% set categoriesPageQuery = site.pages.find({type: 'categories'}, {lean: true}) %}
            {% set hasCategoriesPage = categoriesPageQuery.length > 0 %}
            <div class="site-state-item site-state-categories">
              {% if hasCategoriesPage %}<a href="{{ url_for(categoriesPageQuery[0].path) }}">{% endif %}
                <span class="site-state-item-count">{{ site.categories.length }}</span>
                <span class="site-state-item-name">{{ __('state.categories') }}</span>
              {% if hasCategoriesPage %}</a>{% endif %}
            </div>
          {% endif %}

          {% if config.archive_dir != '/' %}
            <div class="site-state-item site-state-posts">
              <a href="{{ url_for(theme.menu.archives) }}">
                <span class="site-state-item-count">{{ site.posts.length }}</span>
                <span class="site-state-item-name">{{ __('state.posts') }}</span>
              </a>
            </div>
          {% endif %}

          {% if site.tags.length > 0 %}
            {% set tagsPageQuery = site.pages.find({type: 'tags'}, {lean: true}) %}
            {% set hasTagsPage = tagsPageQuery.length > 0 %}
            <div class="site-state-item site-state-tags">
              {% if hasTagsPage %}<a href="{{ url_for(tagsPageQuery[0].path) }}">{% endif %}
                <span class="site-state-item-count">{{ site.tags.length }}</span>
                <span class="site-state-item-name">{{ __('state.tags') }}</span>
              {% if hasTagsPage %}</a>{% endif %}
            </div>
          {% endif %}

          <div class="site-state-item site-state-about">
            <a href="/about/">
              <span class="site-state-item-about fa fa-fw fa-user"></span>
              <span class="site-state-item-name">关于</span>
            </a>
          </div>
          
        </nav>

        {% if theme.rss %}
          <div class="feed-link motion-element">
            <a href="{{ url_for(theme.rss) }}" rel="alternate">
              <i class="fa fa-rss"></i>
              RSS
            </a>
          </div>
        {% endif %}

        <div class="links-of-author motion-element">
          {% if theme.social %}
            {% for name, link in theme.social %}
              <span class="links-of-author-item">
                <a href="{{ link }}" target="_blank" title="{{ name }}">
                  {% if theme.social_icons.enable %}
                    <i class="fa fa-fw fa-{{ theme.social_icons[name] | default('globe') | lower }}"></i>
                  {% endif %}
                    {% if not theme.social_icons.icons_only %}
                      {{ name }}
                    {% endif %}
                </a>
              </span>
            {% endfor %}
          {% endif %}
          
          <!-- 网易云音乐 -->
            <!-- <div class="netease-cloud-music"> -->
              <!-- <iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width=280 height=110 src="//music.163.com/outchain/player?type=0&id=992743594&auto=0&height=90"></iframe> -->
            <!-- </div> -->
          <!-- 网易云音乐 -->

        </div>

        {% set cc = {'by': 1, 'by-nc': 1, 'by-nc-nd': 1, 'by-nc-sa': 1, 'by-nd': 1, 'by-sa': 1, 'zero': 1} %}
        {% if theme.creative_commons in cc %}
          <div class="cc-license motion-element" itemprop="license">
            <a href="https://creativecommons.org/{% if theme.creative_commons === 'zero' %}publicdomain/zero/1.0{% else %}licenses/{{ theme.creative_commons }}/4.0{% endif %}/" class="cc-opacity" target="_blank">
              <img src="{{ url_for(theme.images) }}/cc-{{ theme.creative_commons }}.svg" alt="Creative Commons" />
            </a>
          </div>
        {% endif %}

        {# Blogroll #}
        {% if theme.links %}
          <div class="links-of-blogroll motion-element {{ "links-of-blogroll-" + theme.links_layout | default('inline') }}">
            <div class="links-of-blogroll-title">
              <i class="fa  fa-fw fa-{{ theme.links_icon | default('globe') | lower }}"></i>
              {{ theme.links_title }}
            </div>
            <ul class="links-of-blogroll-list">
              {% for name, link in theme.links %}
                <li class="links-of-blogroll-item">
                  <a href="{{ link }}" title="{{ name }}" target="_blank">{{ name }}</a>
                </li>
              {% endfor %}
            </ul>
          </div>
        {% endif %}

        {% include '../_custom/sidebar.swig' %}
        


      </section>

      {% if display_toc and toc(page.content).length > 1 %}
      <!--noindex-->
        <section class="post-toc-wrap motion-element sidebar-panel sidebar-panel-active">
          <div class="post-toc">

            {% if page.toc_number === undefined %}
              {% set toc = toc(page.content, { "class": "nav", list_number: theme.toc.number }) %}
            {% else %}
              {% set toc = toc(page.content, { "class": "nav", list_number: page.toc_number }) %}
            {% endif %}

            {% if toc.length <= 1 %}
              <p class="post-toc-empty">{{ __('post.toc_empty') }}</p>
            {% else %}
              <div class="post-toc-content">{{ toc }}</div>
            {% endif %}

          </div>
        </section>
      <!--/noindex-->
      {% endif %}

    </div>
  </aside>
{% endmacro %}
