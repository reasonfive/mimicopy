class ChordsController < ApplicationController
    protect_from_forgery
    helper_method :chord_types
    def chord_types
        ChordType.order(:id)
    end

    # 登録済みコードの一覧
    def index
        @pagename = "登録コード一覧"
        @chord_types = ChordType.order(:id)

    end

    # コードの登録
    def new
        @pagename = "コードの登録"

    end

    # 登録内容の確認
    def confirm
        @pagename = "確認"
        @chord_type = params.require(:chord_type)
        @select_notes_ids = []

        params[:select_notes].each do | di1,di2 |

            # チェックボックスにチェックがついている場合
            if di2 == "1"
                @select_notes_ids.push(di1)
            end
        end 

    end

    # 登録の完了
    def create
        @pagename = "登録完了"

        chord_type = ChordType.new
        chord_type.name = params.require(:chord_type)
        chord_type.save
        chord_type.reload

        chord_type_id = chord_type.id

        select_notes_ids = params.require(:select_notes_ids).delete('[]"').split(',').map{|n| n.to_i}
        select_notes_ids_minus_one = select_notes_ids.map{|n| n - 1 }
        select_notes_ids_minus_one.shift()
        # [0, 2, 4, 5, 7, 9, 11]
        pp select_notes_ids_minus_one

        notes.each do |note|
            chord = Chord.new
            chord.chord_type_id = chord_type_id
            chord.root_note_id = note.id
            chord.save
            chord.reload

            # ROOT音に対する処理
            chord.constituent_sound = "#{note.name}"
            root_chord_note = ChordNote.new
            root_chord_note.chord_id = chord.id
            root_chord_note.note_id = note.id
            root_chord_note.save

            select_notes_ids_minus_one.each do |select_notes_id_minus_one|
                add_note_id = chord.root_note_id + select_notes_id_minus_one
                add_note_id = add_note_id - 12 if add_note_id > 12
                add_note = Note.find(add_note_id)

                chord.constituent_sound = "#{chord.constituent_sound}, #{add_note.name}"
                chord_note = ChordNote.new
                chord_note.chord_id = chord.id
                chord_note.note_id = add_note.id
                chord_note.save
                
            end

            chord.save

        end

        render action: :index

    end

    # コードの検索
    def search
        @pagename = "検索"
        @notes = Note.order(:id)
        @result_msgs = []
        if request.post?
            # 検索ボタン押下時

            select_notes_ids = []
            params[:select_notes].each do | di1,di2 |
                # チェックボックスにチェックがついている場合
                if di2 == "1"
                    select_notes_ids.push(di1)
                end
            end
            select_notes_ids = select_notes_ids.map{|n| n.to_i}

            chords = Chord.all
            chords.each do |chord|
                chord_note_ids = ChordNote.where(chord_id: chord.id).pluck(:note_id)
                intersection = chord_note_ids & select_notes_ids
                match_rate = intersection.size/select_notes_ids.size.round(2).to_f*100

                if match_rate > 70
                    result_msg = "#{Note.find(chord.root_note_id).name}#{ChordType.find(chord.chord_type_id).name}コード（#{chord.constituent_sound}）合致率#{match_rate.to_i}パーセント"
                    @result_msgs.push(result_msg)
                end
            end
        end
    end
end
