/*
 * CRAGEの見積の構造
 */
module CRAGE

sig 大項目{
	内容: some 中項目
}
sig 中項目{
	内容: some (グループ項目+小項目)
}{
  -- 小項目は必須
	some (内容 & 小項目)
}
sig グループ項目{
}
sig 小項目{
}


fact {
  all x : 中項目 | one 内容.x
  all x : 小項目 | one 内容.x
  all x : グループ項目 | one 内容.x
}

// 性質の保証
pred 複数の大項目に属す(y: 小項目+グループ項目){
	 some disj x,x': 大項目 | y in x.内容.内容 and y in x'.内容.内容
}
assert どんな小項目もただ1つの大項目に属す{
  no x : 小項目+グループ項目 | 複数の大項目に属す[x]
//	no y : (グループ項目+小項目) | some disj x,x': 大項目 | y in x.内容.内容 and y in x'.内容.内容
}
check どんな小項目もただ1つの大項目に属す

pred 大項目は一意(x: 小項目+グループ項目){
  one 内容.内容.x
}

assert どんな小項目も必ず1つの大項目に属す{
  all x: 小項目+グループ項目 | 大項目は一意[x]
}
check どんな小項目も必ず1つの大項目に属す

assert 二つの命題は同じ {
  all x: 小項目+グループ項目 | !複数の大項目に属す[x] <=> 大項目は一意[x]
}
check 二つの命題は同じ

/*
assert グループだけからなる中項目はない{
  all x:中項目 | let y = x.内容 | #(y - グループ項目) > 0
}
check グループだけからなる中項目はない
*/

pred show {
}
run show
