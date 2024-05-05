class PrepareArticlesForAuthorAssociation < ActiveRecord::Migration[6.0]
  def up
    execute "DELETE FROM comments;"
    execute "DELETE FROM articles;"
    add_reference :articles, :author, null: false, foreign_key: true
  end

  def down
    remove_reference :articles, :authors, foreign_key: true

  end
end
