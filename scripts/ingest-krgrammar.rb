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
  con = PG.connect({ :host => '0.0.0.0', :port => 5444, :dbname => 'gongbu', :user => 'gongbu', :password => 'gongbu' })

  con.exec "DROP TABLE IF EXISTS grammars"
  con.exec "CREATE TABLE grammars (id SERIAL, grammar_name TEXT, translation_en TEXT)"

  con.exec "DELETE FROM grammars where 1=1"
  con.prepare('stm1', 'INSERT INTO grammars (grammar_name, translation_en) VALUES ($1, $2)')

  grammars = JSON.parse(File.read('../data/krgrammar.json'))
  grammars.each do |g|
    con.exec_prepared('stm1', [g['name'], g['translation']])
  end

  rs = con.exec('SELECT count(*) from grammars')
  puts "inserted: #{rs.values}"
rescue PG::Error => e
  puts e.message
ensure
  con.close if con
end
