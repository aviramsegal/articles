import Text.Pandoc

main = interact $ jsonFilter $ \(Pandoc meta blocks) ->
              Pandoc meta (addMinipages blocks)

addMinipages :: [Block] -> [Block]
addMinipages (OrderedList attr lst : xs) = 
    [ OrderedList attr (map addMinipages lst) ] ++ addMinipages xs
addMinipages (BulletList lst : xs) = 
    [ BulletList (map addMinipages lst) ] ++ addMinipages xs
addMinipages (CodeBlock attr code : xs) =
            [ RawBlock "latex" "\\begin{minipage}{\\linewidth}"
            , CodeBlock attr code
            , RawBlock "latex" "\\end{minipage}" ]
            ++ addMinipages xs
addMinipages (x:xs) = x : addMinipages xs
addMinipages [] = []