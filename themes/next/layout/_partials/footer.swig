<div class="copyright" >
  {% set current = date(Date.now(), "YYYY") %}
  &copy; {% if theme.since and theme.since != current %} {{ theme.since }} - {% endif %}
  <span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="fa fa-{{ theme.authoricon }}"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ config.author }}</span>
</div>

{% if theme.copyright %}
<div class="powered-by">
  {{ __('footer.powered', '<a class="theme-link" href="https://hexo.io">Hexo</a>') }}
</div>

<div class="theme-info">
  {{ __('footer.theme') }} -
  <a class="theme-link" href="https://github.com/iissnan/hexo-theme-next">
    NexT.{{ theme.scheme }}
  </a>
</div>
<script async src="https://dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js"></script>
<div style="margin:-20px;position: absolute;right:265px;">
<dl style="float:left">
  <dt style="float:left">
    <dd style="float:left;width:300px">
      <span style="float:right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|</span>
      <span style="float:right">本站总访问量<span><span style="float:right" id="busuanzi_value_site_pv"></span>
    </dd>
  </dt>
  <dt style="float:left;width:300px">
    <dd>
      <span style="float:left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
      <span style="float:left">您是第</span>
      <span style="float:left" id="busuanzi_value_site_uv"></span>
      <span style="float:left">个小伙伴</span>
    </dd>
  </dt>
</dl>
</div>
{% endif %}
