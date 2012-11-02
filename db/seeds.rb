puts "Creating default user..."

User.create! email: "admin@user.com", 
             password: "letmein", 
             password_confirmation: "letmein"

puts "Default user created!"

Setting.create! site_name: "Represent", facebook_page: "", twitter_handle: "@representph", analytics_snippet: " <script type='text/javascript'>

                    var _gaq = _gaq || [];
                    _gaq.push(['_setAccount', 'UA-XXXXX-X']);
                    _gaq.push(['_trackPageview']);

                    (function() {
                      var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
                      ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
                    })();

                  </script>"
