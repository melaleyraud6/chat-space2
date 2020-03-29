class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :body
      t.text :image
      t.references :group, foreign_key: true # group_idとuser_idはreferences型で設定してあるので、カラム名に_idは不要です。
      t.references :user, foreign_key: true  # referencesを使用するとインデックスの設定も自動的に行われます。
      t.timestamps
    end
  end
end
