$p = "C:\Users\LENOVO\.magicore\accounts\b4bf866f-4ca0-40fc-9e0d-9f57c2612e25\workspaces\agents\da789480-8214-40ec-9fe0-25533902df6f\社团一站通-美化版\index.html"
$h = [System.IO.File]::ReadAllText($p, [System.Text.Encoding]::UTF8)

$replacements = @(
    @('"白杨剧团":"assets/club-musical.jpg"','"白杨剧团":"assets/club-theater.jpg"'),
    @('"「笑生堂」相声社":"assets/club-musical.jpg"','"「笑生堂」相声社":"assets/club-comedy.jpg"'),
    @('"青果文学社":"assets/club-books.jpg"','"青果文学社":"assets/club-novel.jpg"'),
    @('"衔青网文社":"assets/club-books.jpg"','"衔青网文社":"assets/club-novel.jpg"'),
    @('"非通用语言协会":"assets/club-books.jpg"','"非通用语言协会":"assets/club-language.jpg"'),
    @('"中韩交流协会":"assets/club-books.jpg"','"中韩交流协会":"assets/club-language.jpg"'),
    @('"未来媒体协会":"assets/club-esports.jpg"','"未来媒体协会":"assets/club-future.jpg"'),
    @('"X-Roller冰雪轮滑俱乐部":"assets/club-esports.jpg"','"X-Roller冰雪轮滑俱乐部":"assets/club-roller.jpg"'),
    @('"PASSWORD街舞社":"assets/club-dance.jpg"','"PASSWORD街舞社":"assets/club-street.jpg"'),
    @('"清影舞社":"assets/club-dance.jpg"','"清影舞社":"assets/club-social.jpg"'),
    @('"Abrazo Project社交舞团（筹）":"assets/club-dance.jpg"','"Abrazo Project社交舞团（筹）":"assets/club-social.jpg"'),
    @('"模拟联合国社团":"assets/club-debate.jpg"','"模拟联合国社团":"assets/club-un.jpg"'),
    @('"国际组织与全球治理社团":"assets/club-debate.jpg"','"国际组织与全球治理社团":"assets/club-gov.jpg"'),
    @('"SelfLove自我成长社":"assets/club-service.jpg"','"SelfLove自我成长社":"assets/club-selflove.jpg"'),
    @('"三农学社":"assets/club-service.jpg"','"三农学社":"assets/club-rural.jpg"'),
    @('"摄影协会":"assets/club-film.jpg"','"摄影协会":"assets/club-badminton.jpg"'),
    @('"浪潮电影社":"assets/club-film.jpg"','"浪潮电影社":"assets/club-film.jpg"'),
    @('"多语融媒社":"assets/club-media.jpg"','"多语融媒社":"assets/club-media.jpg"')
)

$count = 0
foreach($r in $replacements){
    if($h.Contains($r[0])){
        $h = $h.Replace($r[0], $r[1])
        $count++
    }
}

[System.IO.File]::WriteAllText($p, $h, [System.Text.Encoding]::UTF8)
Write-Output "Replaced $count image mappings"

# Verify no duplicates remain
$mapSection = [regex]::Match($h, 'var M=\{[\s\S]*?\};').Value
$pairs = [regex]::Matches($mapSection, '"([^"]+)"\s*:\s*"([^"]+)"')
$imgMap = @{}
foreach($pair in $pairs){ $imgMap[$pair.Groups[1].Value] = $pair.Groups[2].Value }
$dupes = $imgMap.Values | Group-Object | Where-Object { $_.Count -gt 1 }
Write-Output "Remaining duplicates: $($dupes.Count)"
foreach($d in $dupes){ Write-Output "  $($d.Name) x$($d.Count)" }