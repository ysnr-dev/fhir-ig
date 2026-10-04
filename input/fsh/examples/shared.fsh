// 例の参照先になる共通リソース。各ドメインの例はこの id を参照する。

Instance: example-organization
InstanceOf: FC_Facility
Usage: #example
Title: "施設(自院)の例"
Description: "施設(自院)の例"
* identifier[medicalInstitutionCode].system = $JP_InsuranceMedicalInstitutionNo
* identifier[medicalInstitutionCode].value = "1311234567"
* active = true
* type = $organization-type#prov "医療提供施設"
* name = "テスト病院"
* telecom[0].system = #phone
* telecom[0].value = "03-1234-5678"
* address.text = "東京都千代田区1-1-1"
* address.postalCode = "100-0001"

Instance: example-department
InstanceOf: FC_Department
Usage: #example
Title: "診療科の例"
Description: "診療科の例"
* identifier[departmentCode].system = $ssmix2-department
* identifier[departmentCode].value = "01"
* active = true
* type = $organization-type#dept "部門・診療科"
* name = "内科"
* partOf = Reference(Organization/example-organization)

Instance: example-patient
InstanceOf: FC_Patient
Usage: #example
Title: "患者の例"
Description: "患者の例"
* identifier.system = $JP_MRN
* identifier.value = "00000001"
* name[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-representation"
* name[0].extension[0].valueCode = #IDE
* name[0].family = "テスト"
* name[0].given = "太郎"
* name[1].extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-representation"
* name[1].extension[0].valueCode = #SYL
* name[1].family = "テスト"
* name[1].given = "タロウ"
* gender = #male
* birthDate = "1960-01-01"
* active = true

Instance: example-practitioner
InstanceOf: FC_Practitioner
Usage: #example
Title: "医師の例"
Description: "医師の例"
* name[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-representation"
* name[0].extension[0].valueCode = #IDE
* name[0].family = "山田"
* name[0].given = "一郎"
* name[1].extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-representation"
* name[1].extension[0].valueCode = #SYL
* name[1].family = "ヤマダ"
* name[1].given = "イチロウ"
* qualification[0].identifier.system = $mhlw-medicalRegistrationNumber
* qualification[0].identifier.value = "123456"
* qualification[0].code = $JP_MedicalLicenseCertificate#medical-registration
* active = true

Instance: example-nurse
InstanceOf: FC_Practitioner
Usage: #example
Title: "看護師の例"
Description: "看護師の例"
* name[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-representation"
* name[0].extension[0].valueCode = #IDE
* name[0].family = "看護"
* name[0].given = "花子"
* name[1].extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-representation"
* name[1].extension[0].valueCode = #SYL
* name[1].family = "カンゴ"
* name[1].given = "ハナコ"
* active = true

Instance: example-nurse-2
InstanceOf: FC_Practitioner
Usage: #example
Title: "看護師の例(承認者)"
Description: "看護師の例(看護サマリーの承認者)"
* name[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-representation"
* name[0].extension[0].valueCode = #IDE
* name[0].family = "病棟"
* name[0].given = "春子"
* name[1].extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-representation"
* name[1].extension[0].valueCode = #SYL
* name[1].family = "ビョウトウ"
* name[1].given = "ハルコ"
* active = true

Instance: example-ward
InstanceOf: FC_Ward
Usage: #example
Title: "病棟の例"
Description: "病棟の例"
* status = #active
* name = "東3階病棟"
* mode = #instance
* type = $v3-RoleCode#HU "病棟"
* physicalType = $location-physical-type#wa
* managingOrganization = Reference(Organization/example-organization)

Instance: example-room
InstanceOf: FC_HospitalRoom
Usage: #example
Title: "病室の例"
Description: "病室の例"
* status = #active
* name = "301"
* mode = #instance
* type = http://fhir-client.local/CodeSystem/room-class#general "一般室"
* physicalType = $location-physical-type#ro
* partOf = Reference(Location/example-ward)

Instance: example-bed
InstanceOf: FC_Bed
Usage: #example
Title: "ベッドの例"
Description: "ベッドの例"
* status = #active
* name = "1"
* mode = #instance
* physicalType = $location-physical-type#bd
* partOf = Reference(Location/example-room)

Instance: example-condition
InstanceOf: FC_Problem
Usage: #example
Title: "プロブレム(病名)の例"
Description: "プロブレム(病名)の例"
* clinicalStatus = $condition-clinical#active "継続"
* verificationStatus = $condition-ver-status#confirmed
* category = $condition-category#problem-list-item
* code.coding[0] = $medis-disease-keyNumber#20050020
* code.coding[1] = $medis-disease-exCode#U23V
* code.coding[2] = $mhlw-masterB-disease#2500015
* code.coding[3] = $mhlw-ICD10#E119
* code.text = "2型糖尿病"
* subject = Reference(Patient/example-patient)
* onsetDateTime = "2024-04-01"
* extension[problemNumber].valuePositiveInt = 1

Instance: example-encounter
InstanceOf: FC_InpatientEncounter
Usage: #example
Title: "入院 Encounter の例"
Description: "入院 Encounter の例"
* status = #in-progress
* class = $v3-ActCode#IMP "inpatient encounter"
* subject = Reference(Patient/example-patient)
* subject.display = "テスト 太郎"
* period.start = "2026-04-01T10:00:00+09:00"
* location[0].location = Reference(Location/example-bed)
* location[0].status = #active
* serviceProvider = Reference(Organization/example-department)
* participant[0].type = $v3-ParticipationType#ATND "attender"
* participant[0].individual = Reference(Practitioner/example-practitioner)
