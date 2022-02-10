class ScalesController < ApplicationController
    protect_from_forgery
    helper_method :scale_types
    def scale_types
        ScaleType.order(:id)
    end

    # 登録済みスケールの一覧
    def index
        @pagename = "登録スケール一覧"
        @scale_types = ScaleType.order(:id)

    end

    # スケールの登録
    def new
        @pagename = "スケールの登録"

    end

    # 登録内容の確認
    def confirm
        @pagename = "確認"
        @scale_type = params.require(:scale_type)
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

        scale_type = ScaleType.new
        scale_type.name = params.require(:scale_type)
        scale_type.save
        scale_type.reload

        scale_type_id = scale_type.id

        select_notes_ids = params.require(:select_notes_ids).delete('[]"').split(',').map{|n| n.to_i}
        select_notes_ids_minus_one = select_notes_ids.map{|n| n - 1 }
        select_notes_ids_minus_one.shift()
        # [0, 2, 4, 5, 7, 9, 11]
        pp select_notes_ids_minus_one

        notes.each do |note|
            scale = Scale.new
            scale.scale_type_id = scale_type_id
            scale.root_note_id = note.id
            scale.save
            scale.reload

            # ROOT音に対する処理
            scale.constituent_sound = "#{note.name}"
            root_scale_note = ScaleNote.new
            root_scale_note.scale_id = scale.id
            root_scale_note.note_id = note.id
            root_scale_note.save

            select_notes_ids_minus_one.each do |select_notes_id_minus_one|
                add_note_id = scale.root_note_id + select_notes_id_minus_one
                add_note_id = add_note_id - 12 if add_note_id > 12
                add_note = Note.find(add_note_id)

                scale.constituent_sound = "#{scale.constituent_sound}, #{add_note.name}"
                scale_note = ScaleNote.new
                scale_note.scale_id = scale.id
                scale_note.note_id = add_note.id
                scale_note.save
                
            end

            scale.save

        end

        render action: :index

    end

    # スケールの検索
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

            scales = Scale.all
            scales.each do |scale|
                scale_note_ids = ScaleNote.where(scale_id: scale.id).pluck(:note_id)
                intersection = scale_note_ids & select_notes_ids
                match_rate = intersection.size/select_notes_ids.size.round(2).to_f*100

                if match_rate > 70
                    result_msg = "#{Note.find(scale.root_note_id).name}#{ScaleType.find(scale.scale_type_id).name}スケール（#{scale.constituent_sound}）合致率#{match_rate.to_i}パーセント"
                    @result_msgs.push(result_msg)
                end
            end
        end
    end
end
