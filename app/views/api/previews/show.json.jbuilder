json.extract! @preview, :id, :title, :html, :css, :js, :author_id
json.author @preview.author, :id, :email
