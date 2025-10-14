#!/bin/bash

echo "🚀 Démarrage de la création des fichiers de métadonnées..."
# ==============================================================================
# SCRIPT POUR CRÉER LES FICHIERS DE MÉTRADONNÉES (CHAMPS & GLOBAL VALUE SETS)
# ==============================================================================

# --- A. CRÉATION DES LISTES DE VALEURS GLOBALES (GLOBAL VALUE SETS) ---
echo "⚙️  Création des Global Value Sets..."
mkdir -p force-app/main/default/globalValueSets

# 1. Gender
cat << EOF > force-app/main/default/globalValueSets/Gender.globalValueSet-meta.xml
<?xml version="1.0" encoding="UTF-8"?>
<GlobalValueSet xmlns="http://soap.sforce.com/2006/04/metadata">
    <masterLabel>Gender</masterLabel>
    <sorted>false</sorted>
    <customValue><fullName>Homme</fullName><default>false</default><label>Homme</label></customValue>
    <customValue><fullName>Femme</fullName><default>false</default><label>Femme</label></customValue>
    <customValue><fullName>Préfère ne pas répondre</fullName><default>false</default><label>Préfère ne pas répondre</label></customValue>
</GlobalValueSet>
EOF

# 2. Age Range
cat << EOF > force-app/main/default/globalValueSets/Age_Range.globalValueSet-meta.xml
<?xml version="1.0" encoding="UTF-8"?>
<GlobalValueSet xmlns="http://soap.sforce.com/2006/04/metadata">
    <masterLabel>Age Range</masterLabel>
    <sorted>false</sorted>
    <customValue><fullName>15-25</fullName><default>false</default><label>15-25 ans</label></customValue>
    <customValue><fullName>26-35</fullName><default>false</default><label>26-35 ans</label></customValue>
    <customValue><fullName>36-45</fullName><default>false</default><label>36-45 ans</label></customValue>
    <customValue><fullName>46-55</fullName><default>false</default><label>46-55 ans</label></customValue>
    <customValue><fullName>56+</fullName><default>false</default><label>56 ans et plus</label></customValue>
</GlobalValueSet>
EOF

# 3. Interests
cat << EOF > force-app/main/default/globalValueSets/Interests.globalValueSet-meta.xml
<?xml version="1.0" encoding="UTF-8"?>
<GlobalValueSet xmlns="http://soap.sforce.com/2006/04/metadata">
    <masterLabel>Interests</masterLabel>
    <sorted>false</sorted>
    <customValue><fullName>Livres</fullName><default>false</default><label>Livres</label></customValue>
    <customValue><fullName>GCAP</fullName><default>false</default><label>GCAP</label></customValue>
    <customValue><fullName>Formation en ligne</fullName><default>false</default><label>Formation en ligne</label></customValue>
    <customValue><fullName>Développement Personnel</fullName><default>false</default><label>Développement Personnel</label></customValue>
    <customValue><fullName>Voyages de formation</fullName><default>false</default><label>Voyages de formation</label></customValue>
</GlobalValueSet>
EOF

# 4. Customer Level
cat << EOF > force-app/main/default/globalValueSets/Customer_Level.globalValueSet-meta.xml
<?xml version="1.0" encoding="UTF-8"?>
<GlobalValueSet xmlns="http://soap.sforce.com/2006/04/metadata">
    <masterLabel>Customer Level</masterLabel>
    <sorted>false</sorted>
    <customValue><fullName>Nouveau</fullName><default>true</default><label>Nouveau</label></customValue>
    <customValue><fullName>Ancien</fullName><default>false</default><label>Ancien</label></customValue>
    <customValue><fullName>VIP</fullName><default>false</default><label>VIP</label></customValue>
</GlobalValueSet>
EOF

# 5. Communication Preferences
cat << EOF > force-app/main/default/globalValueSets/Communication_Preferences.globalValueSet-meta.xml
<?xml version="1.0" encoding="UTF-8"?>
<GlobalValueSet xmlns="http://soap.sforce.com/2006/04/metadata">
    <masterLabel>Communication Preferences</masterLabel>
    <sorted>false</sorted>
    <customValue><fullName>Email</fullName><default>true</default><label>Email</label></customValue>
    <customValue><fullName>SMS</fullName><default>false</default><label>SMS</label></customValue>
    <customValue><fullName>Appel</fullName><default>false</default><label>Appel</label></customValue>
</GlobalValueSet>
EOF

# --- B. CRÉATION DES CHAMPS PERSONNALISÉS ---
echo "⚙️  Création des champs pour l'objet Lead..."
mkdir -p force-app/main/default/objects/Lead/fields

cat << EOF > force-app/main/default/objects/Lead/fields/Gender__c.field-meta.xml
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Gender__c</fullName>
    <label>Gender</label>
    <type>Picklist</type>
    <valueSet><restricted>true</restricted><valueSetName>Gender</valueSetName></valueSet>
</CustomField>
EOF

cat << EOF > force-app/main/default/objects/Lead/fields/Age_Range__c.field-meta.xml
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Age_Range__c</fullName>
    <label>Age Range</label>
    <type>Picklist</type>
    <valueSet><restricted>true</restricted><valueSetName>Age_Range</valueSetName></valueSet>
</CustomField>
EOF

cat << EOF > force-app/main/default/objects/Lead/fields/Interest__c.field-meta.xml
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Interest__c</fullName>
    <label>Interest</label>
    <type>MultiselectPicklist</type>
    <visibleLines>4</visibleLines>
    <valueSet><restricted>true</restricted><valueSetName>Interests</valueSetName></valueSet>
</CustomField>
EOF

cat << EOF > force-app/main/default/objects/Lead/fields/RGPD_Consent__c.field-meta.xml
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>RGPD_Consent__c</fullName>
    <defaultValue>false</defaultValue>
    <label>RGPD Consent</label>
    <type>Checkbox</type>
</CustomField>
EOF

echo "⚙️  Création des champs pour l'objet Contact..."
mkdir -p force-app/main/default/objects/Contact/fields

cat << EOF > force-app/main/default/objects/Contact/fields/Gender__c.field-meta.xml
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Gender__c</fullName>
    <label>Gender</label>
    <type>Picklist</type>
    <valueSet><restricted>true</restricted><valueSetName>Gender</valueSetName></valueSet>
</CustomField>
EOF

cat << EOF > force-app/main/default/objects/Contact/fields/Age_Range__c.field-meta.xml
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Age_Range__c</fullName>
    <label>Age Range</label>
    <type>Picklist</type>
    <valueSet><restricted>true</restricted><valueSetName>Age_Range</valueSetName></valueSet>
</CustomField>
EOF

cat << EOF > force-app/main/default/objects/Contact/fields/Interest__c.field-meta.xml
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Interest__c</fullName>
    <label>Interest</label>
    <type>MultiselectPicklist</type>
    <visibleLines>4</visibleLines>
    <valueSet><restricted>true</restricted><valueSetName>Interests</valueSetName></valueSet>
</CustomField>
EOF

cat << EOF > force-app/main/default/objects/Contact/fields/Student_ID__c.field-meta.xml
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Student_ID__c</fullName>
    <label>Student ID</label>
    <caseSensitive>false</caseSensitive>
    <externalId>true</externalId>
    <length>50</length>
    <required>false</required>
    <trackFeedHistory>false</trackFeedHistory>
    <type>Text</type>
    <unique>true</unique>
</CustomField>
EOF

cat << EOF > force-app/main/default/objects/Contact/fields/Customer_Level__c.field-meta.xml
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Customer_Level__c</fullName>
    <label>Customer Level</label>
    <type>Picklist</type>
    <valueSet><restricted>true</restricted><valueSetName>Customer_Level</valueSetName></valueSet>
</CustomField>
EOF

cat << EOF > force-app/main/default/objects/Contact/fields/Communication_Prefs__c.field-meta.xml
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Communication_Prefs__c</fullName>
    <label>Communication Preferences</label>
    <type>MultiselectPicklist</type>
    <visibleLines>3</visibleLines>
    <valueSet><restricted>true</restricted><valueSetName>Communication_Preferences</valueSetName></valueSet>
</CustomField>
EOF

echo ""
echo "✅ Succès ! Tous les fichiers de métadonnées ont été créés."
echo "➡️  Prochaine étape : mettez à jour votre 'package.xml' puis lancez './deploy.sh'."