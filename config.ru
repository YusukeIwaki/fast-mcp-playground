require './app'
require './mcp_app'

app = FastMcp.rack_middleware(App, name: '私の個人めも', version: '1.0.0', logger: Logger.new(STDOUT)) do |server|
  server.register_tools(PostMemo, UpdateMemo, ListMemos)
end

run app
