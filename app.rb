require 'bundler/setup'
Bundler.require(:default)

# setup ActiveRecord
ActiveRecord::Base.logger = Logger.new($stdout)
ActiveRecord.verbose_query_logs = true
require 'active_support/core_ext'
Time.zone_default = Time.find_zone!("Asia/Tokyo")
ActiveRecord::Base.time_zone_aware_attributes = true
ActiveRecord.default_timezone = :local

# setup Zeitwerk
loader = Zeitwerk::Loader.new
loader.push_dir('./models')
loader.setup

require 'sinatra/base'

class App < Sinatra::Base
  get '/' do
    '<h1>It works!</h1>'
  end
end

if __FILE__ == $0
  require './mcp_app'

  server = FastMcp::Server.new(
    name: '私の個人めも',
    version: '1.0.0',
  )
  server.register_tools(PostMemo, UpdateMemo, ListMemos)
  server.start
end
