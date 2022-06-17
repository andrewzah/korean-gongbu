# schemas

## grammars
#  -------
# id
# name: "가까이"
# meaning_en: "As post-numeral [for] nigh onto, [for] nearly"

## examples
#  --------
# english: ""
# korean: ""
# grammar_id: 1

require 'pg'
require 'json'

begin
  con = PG.connect({ :host => '0.0.0.0', :port => 5444, :dbname => 'gongbu_dev', :user => 'gongbu', :password => 'gongbu' })

  ### this is managed with rails now, do db:migrate ###
  #
  #con.exec "DROP TABLE IF EXISTS grammars"
  #con.exec "CREATE TABLE grammars (id SERIAL,
  #  grammar_name TEXT,
  #  translation_en TEXT,
  #  category_en TEXT,
  #  additional_info TEXT)"

  con.exec "DELETE FROM grammars where 1=1"
  con.prepare('stm1', 'INSERT INTO grammars (name, description_en, category_en, additional_info, created_at, updated_at) VALUES ($1, $2, $3, $4, $5, $6)')

  timestamp = Time.now

  grammars = JSON.parse(File.read('../data/krgrammar.json'))
  grammars.each do |g|
    con.exec_prepared('stm1', [g['name'], g['translation'], g['category_en'], g['additional_info'], timestamp, timestamp])
  end

  rs = con.exec('SELECT count(*) from grammars')
  puts "inserted: #{rs.values}"
rescue PG::Error => e
  puts e.message
ensure
  con.close if con
end
