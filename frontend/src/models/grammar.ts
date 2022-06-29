export default class Grammar {
    name: string;
    description_en: string;
    category_en: string;
    additional_info: string;

    constructor(name: string, description_en: string, category_en: string, additional_info: string) {
        this.name = name;
        this.description_en = description_en;
        this.category_en = category_en;
        this.additional_info = additional_info;
    }
}