require 'fast_mcp'

class PostMemo < FastMcp::Tool
  description 'めもる'

  arguments do
    required(:body).
        filled(:string).
        description('メモする内容')
  end

  def call(body:)
    memo = MemoItem.create!(body: body)

    {
      ID: memo.id,
      Body: memo.body,
      LastUpdatedAt: memo.updated_at.iso8601,
    }
  end
end

class UpdateMemo < FastMcp::Tool
  description 'めも更新して、更新された内容を返す'

  arguments do
    required(:id).
        filled(:integer).
        description('更新するメモのID')

    required(:body).
        filled(:string).
        description('メモする内容')
  end

  def call(id:, body:)
    if memo = MemoItem.find_by(id: id)
      memo.update!(body: body)
      {
        ID: memo.id,
        Body: memo.body,
        LastUpdatedAt: memo.updated_at.iso8601,
      }
    else
      nil
    end
  end
end

class ListMemos < FastMcp::Tool
  description 'めも一覧を返す'

  arguments do
    optional(:limit).
        filled(:integer).
        description('返すメモの数。デフォルトは3')

    optional(:offset).
        filled(:integer).
        description('返すメモのオフセット。デフォルトは0')
  end

  def call(limit: 3, offset: 0)
    MemoItem.order(id: :desc).limit(limit).offset(offset).pluck(:id, :body, :updated_at).map do |id, body, updated_at|
      {
        ID: id,
        Body: body,
        LastUpdatedAt: updated_at.iso8601,
      }
    end
  end
end
