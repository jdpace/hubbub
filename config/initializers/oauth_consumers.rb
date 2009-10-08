# edit this file to contain credentials for the OAuth services you support.
# each entry needs a corresponding token model.
#
# eg. :twitter => TwitterToken, :hour_feed => HourFeedToken etc.
#
# OAUTH_CREDENTIALS={
#   :twitter=>{
#     :key=>"",
#     :secret=>""
#   },
#   :google=>{
#     :key=>"",
#     :secret=>"",
#     :scope=>"" # see http://code.google.com/apis/gdata/faq.html#AuthScopes
#   },
#   :yahoo=>{
#     :key=>"",
#     :secret=>"",
#   },
#   :agree2=>{
#     :key=>"",
#     :secret=>""
#   },
#   :fireeagle=>{
#     :key=>"",
#     :secret=>""
#   },
#   :hour_feed=>{
#     :key=>"",
#     :secret=>"",
#     :options=>{ # OAuth::Consumer options
#       :site=>"http://hourfeed.com" # Remember to add a site for a generic OAuth site
#     }
#   },
#   :nu_bux=>{
#     :key=>"",
#     :secret=>"",
#     :super_class=>"OpenTransactToken",  # if a OAuth service follows a particular standard 
#                                         # with a token implementation you can set the superclass
#                                         # to use
#     :options=>{ # OAuth::Consumer options
#       :site=>"http://nubux.heroku.com" 
#     }
#   }
# }
# 
OAUTH_CREDENTIALS={
  :meetup => {
    :key => "623DFB0291048739434FCB38822B79C8",
    :secret => "873DB54E1C3050830A3605E66AABEBDB", 
    :options => {
      :site=>"http://www.meetup.com/oauth/request/"
    }
  },
  :twitter=>{
    :key    => "ggUVgtxsNrRdbBoW87xXtg",
    :secret => "WcI1CxjClbuIfZVFRMdREdx5EFeED7QaRF0DO0gHII"
  }
} unless defined? OAUTH_CREDENTIALS

load 'oauth/models/consumers/service_loader.rb'