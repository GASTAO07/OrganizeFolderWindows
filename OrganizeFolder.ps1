# Demander à l'utilisateur de saisir le chemin du dossier à organiser
$folderPath = Read-Host "Entrez le chemin du dossier à organiser"

# Récupérer la liste des éléments dans le dossier
$items = Get-ChildItem -Path $folderPath

# Pour chaque élément dans le dossier
foreach ($item in $items) {
    # Déterminer le type de l'élément
    $itemType = $item.Extension

    # Si le type de l'élément n'est pas vide
    if ($itemType -ne "") {
        # Construire le chemin du dossier de type
        $typeFolderPath = Join-Path -Path $folderPath -ChildPath $itemType

        # Si le dossier de type n'existe pas
        if (!(Test-Path -Path $typeFolderPath)) {
            # Créer le dossier de type
            New-Item -ItemType Directory -Path $typeFolderPath
        }

        # Déplacer l'élément dans le dossier de type
        Move-Item -Path $item.FullName -Destination $typeFolderPath
    }
}
