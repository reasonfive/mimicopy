# README
耳コピ支援ツール
  入力した音が含まれるスケールやコードを算出します。

■テーブル
●notesテーブル
  - id integer
  - name(音名) string  (ex)A, A♯
●scale_typesテーブル
  - id integer
  - name(音階名) string  (ex)メジャー, ナチュラルマイナー
●scalesテーブル
  - id integer
  - constituent_sound(構成音) string (ex)C, D, E, F, G, A, B
  - scale_type_id integer
  - root_note_id integer
●scale_notesテーブル
  - id integer
  - scale_id integer
  - note_id integer
●chord_typesテーブル
  - id integer
  - name(音階名) string  (ex)メジャー, ナチュラルマイナー
●chordsテーブル
  - id integer
  - constituent_sound(構成音) string (ex)C, D, E, F, G, A, B
  - chord_type_id integer
  - root_note_id integer
●chord_notesテーブル
  - id integer
  - chord_id integer
  - note_id integer

■機能
●スケールを管理する, コードを管理する
　スケール(音階)やコード(和音)の登録・削除を行います。
●スケールを調べる, コードを調べる
　チェックした音が含まれるスケールやコードを管理画面で登録したスケールやコードから検索します。

This README would normally document whatever steps are necessary to GET the
application up and running.

Things you may want to cover:

* Ruby version 2.6.3

* Rails version Rails 5.2.3