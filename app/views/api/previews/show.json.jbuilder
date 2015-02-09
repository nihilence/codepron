json.extract! @preview, :id, :title, :html, :css, :js, :author_id, :created_at
json.comments @preview.comments, :id, :body, :author_id
