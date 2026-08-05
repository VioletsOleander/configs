# Filter the content block with lines after the 'title' line and before a blank line
export def filter-block [title: string]: list<string> -> list<string> {
    let lines = $in

    mut start_idx = 0
    mut end_idx = 0

    for $line in ($lines | enumerate) {
        if $line.item == $title {
            $start_idx = $line.index + 1
        }
        if $start_idx > 0 and ($line.item | str trim) == '' {
            $end_idx = $line.index - 1
            break
        }
    }

    $lines
    | slice $start_idx..$end_idx
}
