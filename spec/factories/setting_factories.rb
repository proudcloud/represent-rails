FactoryGirl.define do

  factory :setting do
    site_name "Site Name"
    facebook_page "http://facebook.com/sample"
    twitter_handle "@sameple_page"
    analytics_snippet "
      <script type='text/javascript'>

        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-XXXXX-X']);
        _gaq.push(['_trackPageview']);

        (function() {
          var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
          ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();

       </script>"

  end

end
