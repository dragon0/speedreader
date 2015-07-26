numCols2Ids =
    "1"  : ['single']
    "4"  : ['quad_left', 'quad_c_left', 'quad_c_right', 'quad_right']
    "3"  : ['triple_left', 'triple_center', 'triple_right']
    "2"  : ['double_narrow_left', 'double_narrow_right']
    "2w" : ['double_wide_left', 'double_wide_right']
    "2xw": ['double_xwide_left', 'double_xwide_right']

presets =
    'beginner':
        'cols': '1'
        'wpm' : '80'
        'wpc' : '1'
        'ws'  : '5'
    'easy':
        'cols': '4'
        'wpm' : '180'
        'wpc' : '1'
        'ws'  : '5'
    'medium':
        'cols': '3'
        'wpm' : '240'
        'wpc' : '3'
        'ws'  : '5'
    'hard':
        'cols': '2'
        'wpm' : '360'
        'wpc' : '4'
        'ws'  : '5'
    'advanced':
        'cols': '2w'
        'wpm' : '480'
        'wpc' : '6'
        'ws'  : '5'

example_passages =
    '(none)': ''
    'Your Dreams':'You can be whatever you want to be. Each day take one step towards what you want to be and never give up. Dream about what you want to be. Work towards your dream, and one day you will wake up and be just what you want to be.'
    'Believe in Yourself':'Do not ever stop believing in yourself. As long as you believe you can, you will always have reason for trying. Do not wait for what you want to come to you, go after it. Do not run away from love but towards love. Do not allow anyone to hold your happiness in their hands, you hold it in yours. That way, it will always be within your reach and your control.'
    'Growing Up':'It is the problems that make us what we are. It is the fears and the failures and the successes that make us grow and develop. We have to learn to cope with the pains and the fears and the bliss and the million little gifts of life. Only then can we claim that we are growing up into a mature person. We must expect the good and the bad, it is all a part of growing and learning. Go on giving love freely, your supply is endless.'
    'A Yawn':'We yawn when we are tired or sleepy. The reason for this is because our brain will tell our body that we need a little more oxygen, which is the air we breathe in, and so we have that great long yawn. But then why do others yawn when we do? Did they catch the yawn? Your guess is as good as mine.'
    'Look at Life':'Do not run through life so fast that you not only forget where you have been but also where you are going. Life is not a race, it is a beautiful journey, so enjoy each step of the way. Do not be afraid to love. The fastest way to lose love is not to give it at all.'
    'Winners':'Winners don\'t ever give up. When things get rough, they hang in there until the going gets better. Winners take chances, and when they fail, they try again. Winners know that they are not perfect, so then they fall, they do not stay down, they get up and start again. Winners don\'t blame others for their bad times, they accept good and bad and follow their dreams.'
    'Flowers':'Flowers are bright and beautiful so that birds and bees will see and smell them and sip their sweet nectar. Some flowers bloom at night, and these sometimes smell stronger than day flowers so that little creatures that live at night can smell them and also sip some of their sweet nectars.'
    'Sleeping':'Normal people spend about one-third of their lives sleeping. Some people dream a lot, others do not dream very often. The reason people dream is because the brain is sorting out the things that happened during a day. There are times when something happens to remind you of something that happened many years before. This can alos lead to a nice dream.'
    'Gifts':'May a kind word, a loving touch, and a warm smile be yours today and each and every day. May you give these gifts freely every day and may you receive them as well. Try and remember the sunshine when the rain never seems to stop, and the many people who have helped you when you needed help. May you always find someone who will believe in you and trust in you. May you always be strong.'
    'I Give to You':'I give to you, to be yours for all times, the right to the free enjoyment of this world. I give to you the years that are before you and the big wide world that is about you. I give to you this day for it is life, the very life of life, the beauty of growth, the satisfaction of work and the joys of fulfillment. For today well lived, makes every yesterday a vision of hope and every tomorrow a dream come true.\n\nSo, take this day, with the glorious sun that shines over the hills, with the rain that waters the green earth, and the wind that kisses the flowers and the leaves. I give to you the eager hope of the spring, with the right to see the slow disrobing of the gray winter and the entrance of the yellow sun.\n\nI give to you the four seasons, the promise of fall with faith in the fact that all living things will bloom again in spring, the winter with its million pretty things, the hot summer with the berries and the floating clouds that dance across the blue skies. I give to you the night with the right to sleep and the dawn with the vision of the rising sun over the horizon.'

$(->
    intervalID = null
    delay = null
    prevID = null
    passage_ar = null
    col_ar = null
    passage_index = null
    column_index = null

    reset = ->
        clearInterval(intervalID)
        $("#exercises").hide()
        $("#settings").show()
        $("##{prevID}").html("")

    update = ->
        $("##{prevID}").html("")

        if passage_index >= passage_ar.length
            reset()
        else
            prevID = col_ar[column_index]
            column_index = (column_index + 1) % col_ar.length
            $("##{prevID}").text(passage_ar[passage_index])
            $("#out_word").text(passage_ar[passage_index])
            passage_index++

    $("input[name=preset]").click(->
        preset = $('input[name=preset]:checked').val()
        $('select[name=cols]').val(presets[preset]['cols'])
        $('input[name=wpm]').val(presets[preset]['wpm'])
        $('input[name=wpc]').val(presets[preset]['wpc'])
        $('input[name=ws]').val(presets[preset]['ws'])
    )

    $("#exercises").hide()
    $('#reset').click(reset)

    form = $("form")[0]
    form.onsubmit = ->
        #$('input[name=gender]:checked').val()
        textdir = $('input[name=textdir]:checked').val()
        logograms = $('input[name=logograms]')[0].checked
        cols = $('select[name=cols]').val()
        wpm = Number.parseFloat($('input[name=wpm]').val())
        wpc = Number.parseInt($('input[name=wpc]').val())
        ws = Number.parseInt($('input[name=ws]').val())
        passage = $('textarea[name=passage]').val()

        col_ar = numCols2Ids[cols][..]

        if textdir == 'rtl'
            col_ar.reverse()

        prevID = col_ar[col_ar.length - 1]
        passage_index = 0
        column_index = 0

        if logograms
            word_ar = passage.split('')
            ws = 1
        else
            word_ar = passage.split(/\s+/)

        temp_word = ''
        passage_ar = []
        word_count = 0

        for word in word_ar
            if word_count >= wpc and temp_word.length >= ws * wpc
                passage_ar.push(temp_word)
                temp_word = ''
                word_count = 0
            else if temp_word.length != 0
                temp_word += ' '
            temp_word += word
            word_count++

        if temp_word.length != 0
            passage_ar.push(temp_word)

        delay = (60 / (wpm / wpc)) * 1000

        $("#exercises").show()
        $("#settings").hide()

        intervalID = setInterval(update, delay)
        update()

        false

    example_passage = $("select[name=example_passage]")
    for own title, paragraph of example_passages
        option = document.createElement("option")
        option.text = title
        example_passage.append(option)

    example_passage.on('change', ->
        ex_paragraph = example_passage.val()
        $('textarea[name=passage]').val(example_passages[ex_paragraph])
    )
)

