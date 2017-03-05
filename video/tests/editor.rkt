#lang racket

(require rackunit
         racket/gui/base
         "../private/editor.rkt")

(let ()
  (define 3ed
    (new video-editor%
         [track-height 10]
         [minimum-width 100]
         [initial-tracks 3]))
  (define new-3ed
    (send 3ed copy-self))
  (check-equal?
   (send 3ed get-min-height)
   30)
  (check-equal?
   (send 3ed get-min-width)
   100)
  (check-equal?
   (send new-3ed get-min-height)
   30)
  (check-equal?
   (send new-3ed get-min-width)
   100))

(let ()
  (define 4ed
    (new video-editor%
         [track-height 200]
         [minimum-width 500]
         [initial-tracks 4]))
  (check-equal?
   (send 4ed get-min-height)
   800)
  (check-equal?
   (send 4ed get-min-width)
   500)
  (define 4ed-str-out
    (new editor-stream-out-bytes-base%))
  (send 4ed write-to-file (make-object editor-stream-out% 4ed-str-out))
  (define 4ed-str
    (send 4ed-str-out get-bytes))
  (define 4ed-str-in
    (make-object editor-stream-in-bytes-base% 4ed-str))
  (define new-4ed
    (new video-editor%))
  (send new-4ed read-from-file (make-object editor-stream-in% 4ed-str-in))
  (check-equal?
   (send new-4ed get-min-height)
   800)
  (check-equal?
   (send new-4ed get-min-width)
   500))